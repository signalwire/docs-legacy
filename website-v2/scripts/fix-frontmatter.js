const fs = require("fs");
const path = require("path");
const glob = require("glob");

const docsDir = path.resolve(__dirname, "../docs");
const versionedDirs = [
  path.resolve(__dirname, "../realtime-sdk_versioned_docs"),
  path.resolve(__dirname, "../browser-sdk_versioned_docs"),
];

function getAllMdxFiles() {
  const patterns = [docsDir, ...versionedDirs].map(
    (d) => d.replace(/\\/g, "/") + "/**/*.{mdx,md}"
  );
  let files = [];
  for (const p of patterns) {
    files = files.concat(glob.sync(p));
  }
  return files;
}

function fixFrontmatter(content, filePath) {
  // Match frontmatter block
  const fmMatch = content.match(/^---\r?\n([\s\S]*?)\r?\n---/);
  if (!fmMatch) return { content, changed: false };

  let fm = fmMatch[1];
  let changed = false;

  // Fix 1: Remove duplicate description keys (keep the first one)
  const descMatches = [...fm.matchAll(/^description:.*$/gm)];
  if (descMatches.length > 1) {
    // Keep the first description, remove subsequent ones
    for (let i = descMatches.length - 1; i >= 1; i--) {
      const match = descMatches[i];
      fm = fm.substring(0, match.index) + fm.substring(match.index + match[0].length);
      // Remove trailing newline if present
      fm = fm.replace(/\n\n+/g, "\n");
      changed = true;
    }
    console.log(`  Fixed duplicate description in: ${path.relative(process.cwd(), filePath)}`);
  }

  // Fix 2: Convert keywords from string to array
  // Match "keywords: some string value" (not already an array)
  const keywordsStringMatch = fm.match(/^keywords:\s*(?![\[\n])(.*?)$/m);
  if (keywordsStringMatch) {
    const keywordsValue = keywordsStringMatch[1].trim();
    if (keywordsValue && !keywordsValue.startsWith("[") && !keywordsValue.startsWith(">")) {
      // Split by comma, clean up
      const keywordsArray = keywordsValue
        .split(",")
        .map((k) => k.trim())
        .filter(Boolean);
      const newKeywords = `keywords:\n${keywordsArray.map((k) => `  - ${k}`).join("\n")}`;
      fm = fm.replace(keywordsStringMatch[0], newKeywords);
      changed = true;
      console.log(`  Fixed keywords string->array in: ${path.relative(process.cwd(), filePath)}`);
    }
  }

  // Also handle multiline string keywords (using >- or > syntax)
  const keywordsMultilineMatch = fm.match(/^keywords:\s*>-?\s*\n((?:\s{2,}.*\n?)*)/m);
  if (keywordsMultilineMatch) {
    const rawValue = keywordsMultilineMatch[1]
      .split("\n")
      .map((l) => l.trim())
      .filter(Boolean)
      .join(" ");
    const keywordsArray = rawValue
      .split(",")
      .map((k) => k.trim())
      .filter(Boolean);
    const newKeywords = `keywords:\n${keywordsArray.map((k) => `  - ${k}`).join("\n")}`;
    fm = fm.replace(keywordsMultilineMatch[0], newKeywords);
    changed = true;
    console.log(`  Fixed keywords multiline->array in: ${path.relative(process.cwd(), filePath)}`);
  }

  if (changed) {
    const newContent = content.replace(fmMatch[0], `---\n${fm}\n---`);
    return { content: newContent, changed: true };
  }

  return { content, changed: false };
}

const files = getAllMdxFiles();
console.log(`Found ${files.length} files to check`);

let fixedCount = 0;
for (const file of files) {
  const content = fs.readFileSync(file, "utf-8");
  const result = fixFrontmatter(content, file);
  if (result.changed) {
    fs.writeFileSync(file, result.content, "utf-8");
    fixedCount++;
  }
}

console.log(`\nFixed ${fixedCount} files`);
