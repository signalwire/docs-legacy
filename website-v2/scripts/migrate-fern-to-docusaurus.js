#!/usr/bin/env node

/**
 * Migrate Fern MDX content to Docusaurus structure.
 *
 * Usage:
 *   node scripts/migrate-fern-to-docusaurus.js
 *
 * Run from the website-v2 directory.
 */

const fs = require("fs");
const path = require("path");

// ---------------------------------------------------------------------------
// Configuration
// ---------------------------------------------------------------------------

const FERN_BASE = path.resolve(__dirname, "..", "..", "temp", "signalwire-fern-config", "fern");
const PRODUCTS_DIR = path.join(FERN_BASE, "products");
const SNIPPETS_DIR = path.join(FERN_BASE, "snippets");
const DEST_BASE = path.resolve(__dirname, "..");

// Source → destination mapping (relative to PRODUCTS_DIR and DEST_BASE respectively)
const PATH_MAPPINGS = [
  // Order matters: more specific paths must come before less specific ones
  { src: "realtime-sdk/pages/latest/", dest: "docs/realtime-sdk/" },
  { src: "realtime-sdk/pages/v3/", dest: "realtime-sdk_versioned_docs/version-v3/" },
  { src: "realtime-sdk/pages/v2/", dest: "realtime-sdk_versioned_docs/version-v2/" },
  { src: "browser-sdk/pages/latest/", dest: "docs/browser-sdk/" },
  { src: "browser-sdk/pages/v2/", dest: "browser-sdk_versioned_docs/version-v2/" },
  { src: "browser-sdk/pages/click-to-call/", dest: "docs/browser-sdk/click-to-call/" },
  { src: "home/pages/", dest: "docs/main/home/" },
  { src: "platform/pages/", dest: "docs/main/platform/" },
  { src: "swml/pages/", dest: "docs/main/swml/" },
  { src: "call-flow-builder/pages/", dest: "docs/main/call-flow-builder/" },
  { src: "agents-sdk/pages/", dest: "docs/agents-sdk/" },
  { src: "apis/pages/", dest: "docs/main/rest/" },
  { src: "compatibility-api/pages/", dest: "docs/main/compatibility-api/" },
];

// Product slug prefixes from docs.yml — used to strip leading product slug from
// page-level slug: values, since Docusaurus does not auto-prepend them.
const PRODUCT_SLUG_PREFIXES = [
  "platform",
  "swml",
  "call-flow-builder",
  "agents-sdk",
  "server-sdk",
  "browser-sdk",
  "apis",
  "compatibility-api",
];

// ---------------------------------------------------------------------------
// Counters / stats
// ---------------------------------------------------------------------------

let filesProcessed = 0;
let filesCopied = 0;
let errors = [];

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/**
 * Recursively collect all .mdx files under `dir`.
 */
function collectMdxFiles(dir) {
  const results = [];
  if (!fs.existsSync(dir)) return results;

  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const entry of entries) {
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      results.push(...collectMdxFiles(fullPath));
    } else if (entry.isFile() && entry.name.endsWith(".mdx")) {
      results.push(fullPath);
    }
  }
  return results;
}

/**
 * Ensure that the directory for `filePath` exists.
 */
function ensureDir(filePath) {
  const dir = path.dirname(filePath);
  fs.mkdirSync(dir, { recursive: true });
}

/**
 * Determine the destination path for a given source file.
 * Returns null if no mapping matches.
 */
function getDestPath(srcFile) {
  // Make path relative to PRODUCTS_DIR and normalise to forward slashes
  const rel = path.relative(PRODUCTS_DIR, srcFile).replace(/\\/g, "/");

  for (const mapping of PATH_MAPPINGS) {
    if (rel.startsWith(mapping.src)) {
      const remainder = rel.slice(mapping.src.length);
      return path.join(DEST_BASE, mapping.dest, remainder);
    }
  }
  return null;
}

// ---------------------------------------------------------------------------
// Content transformations
// ---------------------------------------------------------------------------

/**
 * Detect whether a given line index falls inside a fenced code block.
 * Pre-computes a set of line indices that are inside code fences.
 */
function buildCodeBlockSet(lines) {
  const inCode = new Set();
  let inside = false;
  for (let i = 0; i < lines.length; i++) {
    if (/^```/.test(lines[i].trimStart())) {
      if (inside) {
        // closing fence — this line is still inside
        inCode.add(i);
        inside = false;
        continue;
      } else {
        inside = true;
        inCode.add(i);
        continue;
      }
    }
    if (inside) inCode.add(i);
  }
  return inCode;
}

/**
 * Convert frontmatter fields from Fern conventions to Docusaurus conventions.
 * Returns the transformed frontmatter string (without the --- delimiters).
 */
function transformFrontmatter(fmBlock) {
  const lines = fmBlock.split("\n");
  const result = [];

  for (const line of lines) {
    // Remove id: <UUID>
    if (/^id:\s+[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\s*$/i.test(line)) {
      continue;
    }

    let transformed = line;

    // subtitle: → description:
    transformed = transformed.replace(/^subtitle:/, "description:");

    // sidebar-title: → sidebar_label:
    transformed = transformed.replace(/^sidebar-title:/, "sidebar_label:");

    // hide-toc: true → hide_table_of_contents: true
    transformed = transformed.replace(/^hide-toc:\s*true/, "hide_table_of_contents: true");

    // position: N → sidebar_position: N
    transformed = transformed.replace(/^position:\s*(\d+)/, "sidebar_position: $1");

    // max-toc-depth: N → toc_max_heading_level: N
    transformed = transformed.replace(/^max-toc-depth:\s*(\d+)/, "toc_max_heading_level: $1");

    // slug: strip leading product prefix
    const slugMatch = transformed.match(/^slug:\s*(.+)$/);
    if (slugMatch) {
      let slugVal = slugMatch[1].trim();
      // Remove surrounding quotes if present
      if ((slugVal.startsWith('"') && slugVal.endsWith('"')) ||
          (slugVal.startsWith("'") && slugVal.endsWith("'"))) {
        slugVal = slugVal.slice(1, -1);
      }
      // Strip leading product prefix (e.g. /swml/foo → /foo, platform/foo → /foo)
      for (const prefix of PRODUCT_SLUG_PREFIXES) {
        const pattern = new RegExp(`^/?${prefix}(/|$)`);
        if (pattern.test(slugVal)) {
          slugVal = slugVal.replace(new RegExp(`^/?${prefix}`), "");
          if (!slugVal.startsWith("/")) slugVal = "/" + slugVal;
          break;
        }
      }
      transformed = `slug: ${slugVal}`;
    }

    // Remove layout: custom (Fern-specific)
    if (/^layout:\s*custom\s*$/.test(transformed)) {
      continue;
    }

    result.push(transformed);
  }

  return result.join("\n");
}

/**
 * Generate a PascalCase import name from a file path.
 * e.g. "/snippets/swml/_playable-sounds.mdx" → "PlayableSoundsPartial"
 */
function generateImportName(snippetPath) {
  const basename = path.basename(snippetPath, ".mdx");
  // Remove leading underscore
  const clean = basename.replace(/^_/, "");
  // Convert kebab-case / snake_case to PascalCase
  const pascal = clean
    .split(/[-_]/)
    .filter(Boolean)
    .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
    .join("");
  return pascal + "Partial";
}

/**
 * Map a Fern snippet src path to a Docusaurus import path.
 * "/snippets/path/to/file.mdx" → "@site/docs/_partials/path/to/file.mdx"
 */
function snippetSrcToImportPath(src) {
  // src looks like "/snippets/path/to/file.mdx"
  const rel = src.replace(/^\/snippets\//, "");
  // Ensure the filename is prefixed with _
  const dir = path.dirname(rel);
  let base = path.basename(rel);
  if (!base.startsWith("_")) {
    base = "_" + base;
  }
  const prefixedRel = dir === "." ? base : dir + "/" + base;
  return `@site/docs/_partials/${prefixedRel}`;
}

/**
 * Apply all content body transformations to the text after frontmatter.
 */
function transformBody(body) {
  const lines = body.split("\n");
  const codeLines = buildCodeBlockSet(lines);
  const imports = []; // { name, path } pairs to add as imports
  const result = [];

  for (let i = 0; i < lines.length; i++) {
    let line = lines[i];
    const inCode = codeLines.has(i);

    if (!inCode) {
      // Convert [#anchor] at end of heading lines to {#anchor}
      line = line.replace(/^(#{1,6}\s+.*?)\s*\[#([^\]]+)\]\s*$/, "$1 {#$2}");

      // Convert class= to className= in JSX tags (not in code blocks)
      // Match class= that's inside a JSX tag (preceded by < on the same or nearby line)
      line = line.replace(/\bclass="/g, 'className="');
      line = line.replace(/\bclass='/g, "className='");
      // Also handle class= without quotes (e.g. class={...})
      // But avoid converting CSS class selectors — only convert when it looks like a JSX attribute
      // We already handled quoted cases; handle class={ too
      line = line.replace(/\bclass=\{/g, "className={");

      // Convert <Markdown src="/snippets/..." /> to import + component
      const markdownMatch = line.match(/<Markdown\s+src="([^"]+)"\s*\/>/);
      if (markdownMatch) {
        const snippetSrc = markdownMatch[1];
        const importName = generateImportName(snippetSrc);
        const importPath = snippetSrcToImportPath(snippetSrc);

        // Check if we already added this import
        if (!imports.find((imp) => imp.name === importName)) {
          imports.push({ name: importName, path: importPath });
        }

        line = line.replace(/<Markdown\s+src="[^"]+"\s*\/>/, `<${importName} />`);
      }

      // Convert <Tab title="X"> to <TabItem value="x" label="X">
      line = line.replace(/<Tab\s+title="([^"]+)"\s*>/g, (_match, title) => {
        const value = title.toLowerCase().replace(/\s+/g, "-");
        return `<TabItem value="${value}" label="${title}">`;
      });

      // Convert </Tab> to </TabItem>
      // Be careful not to convert </Tabs>
      line = line.replace(/<\/Tab>(?!s)/g, "</TabItem>");
    }

    result.push(line);
  }

  // Build the import block
  let importBlock = "";
  if (imports.length > 0) {
    importBlock =
      imports
        .map((imp) => `import ${imp.name} from '${imp.path}';`)
        .join("\n") + "\n\n";
  }

  return importBlock + result.join("\n");
}

/**
 * Process a single MDX file: parse frontmatter, apply transforms, return result.
 */
function transformFile(content) {
  // Split frontmatter from body
  const fmMatch = content.match(/^---\r?\n([\s\S]*?)\r?\n---\r?\n?([\s\S]*)$/);
  if (!fmMatch) {
    // No frontmatter — just transform the body
    return transformBody(content);
  }

  const rawFm = fmMatch[1];
  const rawBody = fmMatch[2];

  const transformedFm = transformFrontmatter(rawFm);
  const transformedBody = transformBody(rawBody);

  return `---\n${transformedFm}\n---\n${transformedBody}`;
}

// ---------------------------------------------------------------------------
// Snippet migration
// ---------------------------------------------------------------------------

function migrateSnippets() {
  const partialsDir = path.join(DEST_BASE, "docs", "_partials");

  if (!fs.existsSync(SNIPPETS_DIR)) {
    console.log("  [SKIP] Snippets directory not found:", SNIPPETS_DIR);
    return;
  }

  const snippetFiles = collectMdxFiles(SNIPPETS_DIR);
  let snippetCount = 0;

  for (const srcFile of snippetFiles) {
    try {
      const rel = path.relative(SNIPPETS_DIR, srcFile).replace(/\\/g, "/");
      // Ensure filename is prefixed with _
      const dir = path.dirname(rel);
      let base = path.basename(rel);
      if (!base.startsWith("_")) {
        base = "_" + base;
      }
      const destRel = dir === "." ? base : path.join(dir, base);
      const destFile = path.join(partialsDir, destRel);

      const content = fs.readFileSync(srcFile, "utf-8");
      const transformed = transformFile(content);

      ensureDir(destFile);
      fs.writeFileSync(destFile, transformed, "utf-8");
      snippetCount++;
    } catch (err) {
      errors.push(`Snippet ${srcFile}: ${err.message}`);
    }
  }

  console.log(`  Snippets migrated: ${snippetCount}`);
}

// ---------------------------------------------------------------------------
// Product page migration
// ---------------------------------------------------------------------------

function migrateProducts() {
  if (!fs.existsSync(PRODUCTS_DIR)) {
    console.error("ERROR: Products directory not found:", PRODUCTS_DIR);
    process.exit(1);
  }

  const allMdx = collectMdxFiles(PRODUCTS_DIR);
  console.log(`  Found ${allMdx.length} MDX files in products/`);

  for (const srcFile of allMdx) {
    filesProcessed++;
    try {
      const destFile = getDestPath(srcFile);
      if (!destFile) {
        // No mapping found — skip
        continue;
      }

      const content = fs.readFileSync(srcFile, "utf-8");
      const transformed = transformFile(content);

      ensureDir(destFile);
      fs.writeFileSync(destFile, transformed, "utf-8");
      filesCopied++;
    } catch (err) {
      errors.push(`${srcFile}: ${err.message}`);
    }
  }
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

function main() {
  console.log("=== Fern → Docusaurus Migration ===\n");
  console.log("Source:      ", FERN_BASE);
  console.log("Destination: ", DEST_BASE);
  console.log();

  console.log("[1/2] Migrating product pages...");
  migrateProducts();
  console.log(`  Files processed: ${filesProcessed}`);
  console.log(`  Files copied:    ${filesCopied}`);
  console.log();

  console.log("[2/2] Migrating snippets...");
  migrateSnippets();
  console.log();

  if (errors.length > 0) {
    console.log(`Errors (${errors.length}):`);
    for (const err of errors) {
      console.log(`  - ${err}`);
    }
  } else {
    console.log("Migration completed successfully with no errors.");
  }
}

main();
