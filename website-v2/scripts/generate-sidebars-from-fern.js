#!/usr/bin/env node

/**
 * generate-sidebars-from-fern.js
 *
 * Reads Fern YAML navigation files and generates Docusaurus sidebar
 * configuration files (TypeScript) in website-v2/config/sidebarsConfig/.
 *
 * Usage:
 *   node scripts/generate-sidebars-from-fern.js
 *
 * Run from the website-v2 directory.
 */

const fs = require("fs");
const path = require("path");

// ---------------------------------------------------------------------------
// Simple YAML parser (handles the subset used by Fern navigation files)
// ---------------------------------------------------------------------------

/**
 * Parse a simple YAML file into a JS object/array structure.
 * Supports: mappings, sequences (- items), quoted/unquoted scalars,
 * inline values, and comments.
 */
function parseYaml(text) {
  const lines = text.split("\n");
  const result = parseBlock(lines, 0, 0);
  return result.value;
}

function getIndent(line) {
  const match = line.match(/^(\s*)/);
  return match ? match[1].length : 0;
}

function stripComment(line) {
  // Naive comment strip - doesn't handle # inside quotes perfectly
  // but sufficient for these files
  let inSingle = false;
  let inDouble = false;
  for (let i = 0; i < line.length; i++) {
    const ch = line[i];
    if (ch === "'" && !inDouble) inSingle = !inSingle;
    if (ch === '"' && !inSingle) inDouble = !inDouble;
    if (ch === "#" && !inSingle && !inDouble) {
      return line.substring(0, i).trimEnd();
    }
  }
  return line;
}

function parseScalar(val) {
  if (val === "true") return true;
  if (val === "false") return false;
  if (val === "null" || val === "~" || val === "") return null;
  if (/^-?\d+$/.test(val)) return parseInt(val, 10);
  if (/^-?\d+\.\d+$/.test(val)) return parseFloat(val);
  // Strip quotes
  if (
    (val.startsWith('"') && val.endsWith('"')) ||
    (val.startsWith("'") && val.endsWith("'"))
  ) {
    return val.slice(1, -1);
  }
  return val;
}

/**
 * Parse a block of YAML lines starting at lineIndex with a minimum indent.
 * Returns { value, nextIndex }.
 */
function parseBlock(lines, lineIndex, minIndent) {
  // Skip blank/comment lines
  while (lineIndex < lines.length) {
    const stripped = lines[lineIndex].trim();
    if (stripped === "" || stripped.startsWith("#")) {
      lineIndex++;
    } else {
      break;
    }
  }

  if (lineIndex >= lines.length) {
    return { value: null, nextIndex: lineIndex };
  }

  const firstLine = lines[lineIndex];
  const firstIndent = getIndent(firstLine);

  if (firstIndent < minIndent) {
    return { value: null, nextIndex: lineIndex };
  }

  const trimmed = firstLine.trim();

  // Check if this is a sequence
  if (trimmed.startsWith("- ") || trimmed === "-") {
    return parseSequence(lines, lineIndex, firstIndent);
  }

  // Otherwise it's a mapping
  return parseMapping(lines, lineIndex, firstIndent);
}

function parseSequence(lines, lineIndex, baseIndent) {
  const result = [];

  while (lineIndex < lines.length) {
    // Skip blank/comment lines
    while (lineIndex < lines.length) {
      const s = lines[lineIndex].trim();
      if (s === "" || s.startsWith("#")) {
        lineIndex++;
      } else {
        break;
      }
    }
    if (lineIndex >= lines.length) break;

    const line = lines[lineIndex];
    const indent = getIndent(line);

    if (indent < baseIndent) break;
    if (indent > baseIndent) break; // shouldn't happen for well-formed YAML

    const trimmed = line.trim();
    if (!trimmed.startsWith("-")) break;

    // Remove the "- " prefix
    const afterDash = trimmed.substring(1).trim();

    if (afterDash === "") {
      // The content is on the next lines, indented further
      lineIndex++;
      const sub = parseBlock(lines, lineIndex, indent + 1);
      result.push(sub.value);
      lineIndex = sub.nextIndex;
    } else if (afterDash.includes(":")) {
      // Inline mapping start: "- key: value"
      // We need to treat this as a mapping where the first key-value is on this line
      // and subsequent lines at deeper indent continue the mapping
      const item = parseSequenceItemMapping(
        lines,
        lineIndex,
        indent,
        afterDash
      );
      result.push(item.value);
      lineIndex = item.nextIndex;
    } else {
      // Simple scalar
      result.push(parseScalar(stripComment(afterDash)));
      lineIndex++;
    }
  }

  return { value: result, nextIndex: lineIndex };
}

/**
 * Parse a mapping that starts as a sequence item (e.g., "- key: value")
 * The first key:value pair is on the same line as the dash.
 */
function parseSequenceItemMapping(lines, lineIndex, dashIndent, firstContent) {
  const obj = {};
  const line = lines[lineIndex];
  // The "virtual" indent for keys in this mapping is dashIndent + 2
  // (i.e., where the content after "- " begins)
  const contentIndent = dashIndent + 2;

  // Parse the first key: value from firstContent
  const colonIdx = findColon(firstContent);
  if (colonIdx === -1) {
    // Not a mapping, just a scalar
    return { value: parseScalar(stripComment(firstContent)), nextIndex: lineIndex + 1 };
  }

  const key = firstContent.substring(0, colonIdx).trim();
  const valPart = stripComment(firstContent.substring(colonIdx + 1).trim());

  if (valPart === "") {
    // Value is a block on subsequent lines
    lineIndex++;
    const sub = parseBlock(lines, lineIndex, contentIndent + 1);
    obj[key] = sub.value;
    lineIndex = sub.nextIndex;
  } else {
    obj[key] = parseScalar(valPart);
    lineIndex++;
  }

  // Continue reading more keys at contentIndent
  while (lineIndex < lines.length) {
    // Skip blanks/comments
    while (lineIndex < lines.length) {
      const s = lines[lineIndex].trim();
      if (s === "" || s.startsWith("#")) {
        lineIndex++;
      } else {
        break;
      }
    }
    if (lineIndex >= lines.length) break;

    const nextLine = lines[lineIndex];
    const nextIndent = getIndent(nextLine);
    const nextTrimmed = nextLine.trim();

    if (nextIndent < contentIndent) break;
    if (nextIndent > contentIndent) break; // nested, shouldn't be a sibling key
    if (nextTrimmed.startsWith("-")) break; // next sequence item

    // This should be another key: value in the same mapping
    const cIdx = findColon(nextTrimmed);
    if (cIdx === -1) break;

    const k = nextTrimmed.substring(0, cIdx).trim();
    const v = stripComment(nextTrimmed.substring(cIdx + 1).trim());

    if (v === "") {
      lineIndex++;
      const sub = parseBlock(lines, lineIndex, nextIndent + 1);
      obj[k] = sub.value;
      lineIndex = sub.nextIndex;
    } else {
      obj[k] = parseScalar(v);
      lineIndex++;
    }
  }

  return { value: obj, nextIndex: lineIndex };
}

function parseMapping(lines, lineIndex, baseIndent) {
  const obj = {};

  while (lineIndex < lines.length) {
    // Skip blanks/comments
    while (lineIndex < lines.length) {
      const s = lines[lineIndex].trim();
      if (s === "" || s.startsWith("#")) {
        lineIndex++;
      } else {
        break;
      }
    }
    if (lineIndex >= lines.length) break;

    const line = lines[lineIndex];
    const indent = getIndent(line);

    if (indent < baseIndent) break;
    if (indent > baseIndent) break;

    const trimmed = line.trim();
    if (trimmed.startsWith("-")) break; // sequence item, not a mapping key

    const colonIdx = findColon(trimmed);
    if (colonIdx === -1) {
      lineIndex++;
      continue;
    }

    const key = trimmed.substring(0, colonIdx).trim();
    const valPart = stripComment(trimmed.substring(colonIdx + 1).trim());

    if (valPart === "") {
      // Block value
      lineIndex++;
      const sub = parseBlock(lines, lineIndex, indent + 1);
      obj[key] = sub.value;
      lineIndex = sub.nextIndex;
    } else {
      obj[key] = parseScalar(valPart);
      lineIndex++;
    }
  }

  return { value: obj, nextIndex: lineIndex };
}

/**
 * Find the first colon that is a key-value separator (not inside quotes).
 */
function findColon(str) {
  let inSingle = false;
  let inDouble = false;
  for (let i = 0; i < str.length; i++) {
    const ch = str[i];
    if (ch === "'" && !inDouble) inSingle = !inSingle;
    if (ch === '"' && !inSingle) inDouble = !inDouble;
    if (ch === ":" && !inSingle && !inDouble) {
      // Must be followed by space, end-of-string, or be at the end
      if (i + 1 >= str.length || str[i + 1] === " ") {
        return i;
      }
    }
  }
  return -1;
}

// ---------------------------------------------------------------------------
// Path mapping configuration
// ---------------------------------------------------------------------------

/**
 * Mapping from Fern product names to Docusaurus doc ID prefixes.
 * SDK products (agents-sdk, browser-sdk, realtime-sdk) have no prefix
 * because they live in separate plugin instances.
 */
const PRODUCT_PREFIX_MAP = {
  home: "home/",
  platform: "platform/",
  swml: "swml/",
  "call-flow-builder": "call-flow-builder/",
  apis: "rest/",
  "compatibility-api": "compatibility-api/",
  // SDK products - no prefix (separate plugin instances)
  "agents-sdk": "",
  "browser-sdk": "",
  "realtime-sdk": "",
};

/**
 * Map from Fern product name to output directory for sidebar config files.
 * Main-docs products go into config/sidebarsConfig/main/,
 * SDK products go into config/sidebarsConfig/<product>/.
 */
const SDK_PRODUCTS = new Set(["agents-sdk", "browser-sdk", "realtime-sdk"]);

// ---------------------------------------------------------------------------
// Fern navigation -> Docusaurus sidebar conversion
// ---------------------------------------------------------------------------

/**
 * Convert a Fern page path (e.g., ./pages/getting-started/quickstart.mdx)
 * to a Docusaurus doc ID (e.g., getting-started/quickstart).
 *
 * @param {string} pagePath - The Fern page path
 * @param {string} prefix - The doc ID prefix for this product
 * @param {string} productDir - The Fern product directory (for resolving relative paths)
 * @returns {string} The Docusaurus doc ID
 */
function pagePathToDocId(pagePath, prefix, productDir) {
  // Normalize the path - remove leading ./
  let normalized = pagePath.replace(/^\.\//, "");
  // If it starts with ../ resolve it relative to productDir
  if (normalized.startsWith("../")) {
    // For versioned SDKs, the pages reference goes up one level
    // e.g., ../pages/latest/reference/core -> pages/latest/reference/core
    // We resolve relative to the product dir
    const resolved = path.posix.normalize(
      path.posix.join(productDir, normalized)
    );
    normalized = resolved;
  }
  // Remove the "pages/" prefix if present
  normalized = normalized.replace(/^(?:.*\/)?pages\//, "");
  // Remove file extension
  normalized = normalized.replace(/\.(mdx?|md)$/, "");
  // Remove trailing /index
  normalized = normalized.replace(/\/index$/, "");

  return prefix + normalized;
}

/**
 * Convert a Fern folder path to a Docusaurus dirName for autogenerated sidebar.
 *
 * @param {string} folderPath - The Fern folder path
 * @param {string} prefix - The doc ID prefix
 * @param {string} productDir - The Fern product directory
 * @returns {string} The Docusaurus dirName
 */
function folderPathToDirName(folderPath, prefix, productDir) {
  let normalized = folderPath.replace(/^\.\//, "");
  if (normalized.startsWith("../")) {
    const resolved = path.posix.normalize(
      path.posix.join(productDir, normalized)
    );
    normalized = resolved;
  }
  // Remove the "pages/" prefix
  normalized = normalized.replace(/^(?:.*\/)?pages\//, "");

  // For SDK products with no prefix, just return the path
  if (prefix === "") {
    return normalized;
  }
  return prefix + normalized;
}

/**
 * Convert a Fern navigation item to a Docusaurus sidebar item.
 *
 * @param {object} item - The Fern navigation item
 * @param {string} prefix - The doc ID prefix
 * @param {string} productDir - The Fern product directory
 * @returns {object} Docusaurus sidebar item
 */
function convertItem(item, prefix, productDir) {
  if (!item || typeof item !== "object") return null;

  // Page item: { page: "Title", path: "./pages/..." }
  if (item.page && item.path) {
    return {
      type: "doc",
      id: pagePathToDocId(item.path, prefix, productDir),
      label: item.page,
    };
  }

  // Folder item: { folder: "./pages/...", title: "Name" }
  if (item.folder) {
    // Skip hidden folders
    if (item.hidden === true) return null;

    const dirName = folderPathToDirName(item.folder, prefix, productDir);
    const title = item.title || path.basename(item.folder);
    return {
      type: "category",
      label: title,
      collapsible: true,
      items: [{ type: "autogenerated", dirName }],
    };
  }

  // Section item: { section: "Title", contents: [...] }
  if (item.section && item.contents) {
    const items = item.contents
      .map((child) => convertItem(child, prefix, productDir))
      .filter(Boolean);
    return {
      type: "category",
      label: item.section,
      collapsible: true,
      items,
    };
  }

  // API item: { api: "Name", "api-name": "slug" }
  // These are OpenAPI-generated sidebars - create a placeholder category
  if (item.api && item["api-name"]) {
    const slug = item.slug || item["api-name"];
    return {
      type: "category",
      label: item.api,
      collapsible: true,
      items: [
        {
          type: "autogenerated",
          dirName: prefix + slug,
        },
      ],
    };
  }

  return null;
}

/**
 * Convert a Fern tab layout to a Docusaurus sidebar.
 *
 * @param {string} tabName - The tab identifier
 * @param {string} tabDisplayName - The display name from tabs config
 * @param {Array} layout - The layout items
 * @param {string} prefix - The doc ID prefix
 * @param {string} productDir - The Fern product directory
 * @returns {object} { sidebarName: string, items: Array }
 */
function convertTabLayout(
  tabName,
  tabDisplayName,
  layout,
  prefix,
  productDir
) {
  const items = layout
    .map((item) => convertItem(item, prefix, productDir))
    .filter(Boolean);

  return { tabName, displayName: tabDisplayName, items };
}

/**
 * Process a Fern navigation YAML file and return sidebar configurations.
 *
 * @param {string} productName - The product identifier
 * @param {object} parsed - The parsed YAML object
 * @param {string} productDir - The product directory (relative, for path resolution)
 * @returns {object} Map of sidebarName -> sidebar items array
 */
function processNavigation(productName, parsed, productDir) {
  // For versioned products like "realtime-sdkV2", strip the version suffix
  // to look up the base product prefix
  const baseProduct = productName.replace(/V\d+$/, "");
  const prefix = PRODUCT_PREFIX_MAP[baseProduct] || "";
  const tabs = parsed.tabs || {};
  const navigation = parsed.navigation;
  const sidebars = {};

  if (!navigation) return sidebars;

  // If navigation is an array of items (could be tabs or direct items)
  const navItems = Array.isArray(navigation) ? navigation : [navigation];

  for (const navItem of navItems) {
    if (navItem.tab) {
      // Tab-based navigation
      const tabName = navItem.tab;
      const tabConfig = tabs[tabName] || {};
      const displayName = tabConfig["display-name"] || tabName;
      const layout = navItem.layout || [];

      // Handle variants (e.g., realtime-sdk v2 with language variants)
      if (navItem.variants) {
        for (const variant of navItem.variants) {
          const variantName = variant.title || "default";
          const variantLayout = variant.layout || [];
          const sidebarName = camelCase(
            `${productName}-${tabName}-${variantName}`
          );
          const converted = convertTabLayout(
            tabName,
            `${displayName} - ${variantName}`,
            variantLayout,
            prefix,
            productDir
          );
          sidebars[sidebarName] = converted.items;
        }
        continue;
      }

      const sidebarName = camelCase(`${productName}-${tabName}`);
      const converted = convertTabLayout(
        tabName,
        displayName,
        layout,
        prefix,
        productDir
      );
      sidebars[sidebarName] = converted.items;
    } else {
      // Direct navigation item (no tab wrapper)
      const converted = convertItem(navItem, prefix, productDir);
      if (converted) {
        // Add to a default sidebar
        const defaultName = camelCase(`${productName}-sidebar`);
        if (!sidebars[defaultName]) {
          sidebars[defaultName] = [];
        }
        sidebars[defaultName].push(converted);
      }
    }
  }

  return sidebars;
}

/**
 * Convert a hyphenated/spaced string to camelCase.
 */
function camelCase(str) {
  return str
    .replace(/[^a-zA-Z0-9]+(.)/g, (_, ch) => ch.toUpperCase())
    .replace(/^[A-Z]/, (ch) => ch.toLowerCase());
}

// ---------------------------------------------------------------------------
// TypeScript code generation
// ---------------------------------------------------------------------------

/**
 * Serialize a sidebar item to TypeScript source code.
 */
function serializeItem(item, indent) {
  const pad = " ".repeat(indent);
  const pad2 = " ".repeat(indent + 2);

  if (item.type === "doc") {
    return `${pad}{\n${pad2}type: "doc",\n${pad2}id: "${item.id}",\n${pad2}label: "${escapeStr(item.label)}",\n${pad}}`;
  }

  if (item.type === "autogenerated") {
    return `${pad}{ type: "autogenerated", dirName: "${item.dirName}" }`;
  }

  if (item.type === "category") {
    const itemsStr = item.items
      .map((child) => serializeItem(child, indent + 4))
      .join(",\n");
    const lines = [
      `${pad}{`,
      `${pad2}type: "category",`,
      `${pad2}label: "${escapeStr(item.label)}",`,
      `${pad2}collapsible: ${item.collapsible !== undefined ? item.collapsible : true},`,
    ];
    if (item.className) {
      lines.push(`${pad2}className: "${item.className}",`);
    }
    lines.push(`${pad2}items: [`);
    lines.push(itemsStr);
    lines.push(`${pad2}],`);
    lines.push(`${pad}}`);
    return lines.join("\n");
  }

  // Fallback
  return `${pad}${JSON.stringify(item)}`;
}

function escapeStr(s) {
  if (!s) return "";
  return s.replace(/\\/g, "\\\\").replace(/"/g, '\\"');
}

/**
 * Generate a TypeScript sidebar config file content.
 *
 * @param {string} varName - The variable name for the export
 * @param {object} sidebars - Map of sidebarName -> items array
 * @returns {string} TypeScript source code
 */
function generateTsFile(varName, sidebars) {
  const lines = [
    `import type { SidebarsConfig } from "@docusaurus/plugin-content-docs";`,
    ``,
    `const ${varName}: SidebarsConfig = {`,
  ];

  for (const [sidebarName, items] of Object.entries(sidebars)) {
    lines.push(`  ${sidebarName}: [`);
    for (const item of items) {
      lines.push(serializeItem(item, 4) + ",");
    }
    lines.push(`  ],`);
    lines.push(``);
  }

  lines.push(`};`);
  lines.push(``);
  lines.push(`export default ${varName};`);
  lines.push(``);

  return lines.join("\n");
}

// ---------------------------------------------------------------------------
// Product definitions
// ---------------------------------------------------------------------------

const FERN_BASE = path.resolve(__dirname, "../../temp/signalwire-fern-config/fern/products");

const PRODUCTS = [
  {
    name: "home",
    yamlPath: "home/home.yml",
    productDir: "home",
    outputFile: "home-sidebar.ts",
    outputDir: "main",
    varName: "homeSidebar",
  },
  {
    name: "agents-sdk",
    yamlPath: "agents-sdk/agents-sdk.yml",
    productDir: "agents-sdk",
    outputFile: "index.ts",
    outputDir: "agents-sdk",
    varName: "agentsSdkSidebars",
  },
  {
    name: "platform",
    yamlPath: "platform/platform.yml",
    productDir: "platform",
    outputFile: "platform-sidebar.ts",
    outputDir: "main",
    varName: "platformSidebars",
  },
  {
    name: "swml",
    yamlPath: "swml/swml.yml",
    productDir: "swml",
    outputFile: "swml-sidebar.ts",
    outputDir: "main",
    varName: "swmlSidebars",
  },
  {
    name: "call-flow-builder",
    yamlPath: "call-flow-builder/call-flow-builder.yml",
    productDir: "call-flow-builder",
    outputFile: "call-flow-builder-sidebar.ts",
    outputDir: "main",
    varName: "callFlowBuilderSidebar",
  },
  {
    name: "apis",
    yamlPath: "apis.yml",
    productDir: "",
    outputFile: "rest-api-sidebar.ts",
    outputDir: "main",
    varName: "restApiSidebars",
  },
  {
    name: "compatibility-api",
    yamlPath: "compatibility-api/compatibility-api.yml",
    productDir: "compatibility-api",
    outputFile: "compatibility-api-sidebar.ts",
    outputDir: "main",
    varName: "compatibilityApiSidebars",
  },
  {
    name: "browser-sdk",
    yamlPath: "browser-sdk/versions/latest.yml",
    productDir: "browser-sdk/versions",
    outputFile: "index.ts",
    outputDir: "browser-sdk",
    varName: "browserSdkSidebars",
    additionalFiles: [
      {
        yamlPath: "browser-sdk/versions/v2.yml",
        productDir: "browser-sdk/versions",
        outputFile: "v2.ts",
        varName: "browserSdkV2Sidebars",
        suffix: "V2",
      },
    ],
  },
  {
    name: "realtime-sdk",
    yamlPath: "realtime-sdk/versions/latest.yml",
    productDir: "realtime-sdk/versions",
    outputFile: "index.ts",
    outputDir: "realtime-sdk",
    varName: "realtimeSdkSidebars",
    additionalFiles: [
      {
        yamlPath: "realtime-sdk/versions/v3.yml",
        productDir: "realtime-sdk/versions",
        outputFile: "v3.ts",
        varName: "realtimeSdkV3Sidebars",
        suffix: "V3",
      },
      {
        yamlPath: "realtime-sdk/versions/v2.yml",
        productDir: "realtime-sdk/versions",
        outputFile: "v2.ts",
        varName: "realtimeSdkV2Sidebars",
        suffix: "V2",
      },
    ],
  },
];

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

function main() {
  const configBase = path.resolve(__dirname, "../config/sidebarsConfig");

  // Track which files go in the "main" directory for the index
  const mainSidebarFiles = [];

  for (const product of PRODUCTS) {
    const yamlFile = path.join(FERN_BASE, product.yamlPath);

    if (!fs.existsSync(yamlFile)) {
      console.warn(`WARNING: YAML file not found: ${yamlFile}`);
      continue;
    }

    const yamlContent = fs.readFileSync(yamlFile, "utf-8");
    const parsed = parseYaml(yamlContent);

    if (!parsed) {
      console.warn(`WARNING: Failed to parse ${yamlFile}`);
      continue;
    }

    const sidebars = processNavigation(
      product.name,
      parsed,
      product.productDir
    );

    // Generate TypeScript file
    const outputDir = path.join(configBase, product.outputDir);
    fs.mkdirSync(outputDir, { recursive: true });

    const tsContent = generateTsFile(product.varName, sidebars);
    const outputPath = path.join(outputDir, product.outputFile);

    fs.writeFileSync(outputPath, tsContent, "utf-8");
    console.log(`Generated: ${path.relative(path.resolve(__dirname, ".."), outputPath)}`);

    if (product.outputDir === "main") {
      mainSidebarFiles.push({
        file: product.outputFile.replace(/\.ts$/, ""),
        varName: product.varName,
      });
    }

    // Process additional version files (for SDKs)
    if (product.additionalFiles) {
      for (const additional of product.additionalFiles) {
        const addYamlFile = path.join(FERN_BASE, additional.yamlPath);
        if (!fs.existsSync(addYamlFile)) {
          console.warn(`WARNING: YAML file not found: ${addYamlFile}`);
          continue;
        }

        const addYamlContent = fs.readFileSync(addYamlFile, "utf-8");
        const addParsed = parseYaml(addYamlContent);

        if (!addParsed) {
          console.warn(`WARNING: Failed to parse ${addYamlFile}`);
          continue;
        }

        // Use a modified product name to differentiate versions
        const versionProductName = `${product.name}${additional.suffix}`;
        const addSidebars = processNavigation(
          versionProductName,
          addParsed,
          additional.productDir
        );

        const addTsContent = generateTsFile(additional.varName, addSidebars);
        const addOutputPath = path.join(outputDir, additional.outputFile);

        fs.writeFileSync(addOutputPath, addTsContent, "utf-8");
        console.log(
          `Generated: ${path.relative(path.resolve(__dirname, ".."), addOutputPath)}`
        );
      }
    }
  }

  // Generate main/index.ts
  generateMainIndex(configBase, mainSidebarFiles);
}

/**
 * Generate the main/index.ts file that aggregates all main-docs sidebars.
 */
function generateMainIndex(configBase, sidebarFiles) {
  const lines = [
    `/**`,
    ` * Main docs instance sidebar configurations`,
    ` *`,
    ` * Auto-generated from Fern YAML navigation files.`,
    ` * Run: node scripts/generate-sidebars-from-fern.js`,
    ` */`,
    ``,
    `import type { SidebarsConfig } from "@docusaurus/plugin-content-docs";`,
  ];

  for (const sf of sidebarFiles) {
    lines.push(`import ${sf.varName} from "./${sf.file}";`);
  }

  lines.push(``);
  lines.push(`const mainSidebars: SidebarsConfig = {`);

  for (const sf of sidebarFiles) {
    lines.push(`  ...${sf.varName},`);
  }

  lines.push(`};`);
  lines.push(``);
  lines.push(`export default mainSidebars;`);
  lines.push(``);

  const indexPath = path.join(configBase, "main", "index.ts");
  fs.mkdirSync(path.dirname(indexPath), { recursive: true });
  fs.writeFileSync(indexPath, lines.join("\n"), "utf-8");
  console.log(
    `Generated: ${path.relative(path.resolve(__dirname, ".."), indexPath)}`
  );
}

main();
