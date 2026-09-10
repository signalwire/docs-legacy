#!/usr/bin/env node

/**
 * Link checker script using lychee.
 *
 * Extracts page URLs from the build sitemap.xml, writes them to a temp file,
 * and runs lychee to validate all links found on those pages.
 *
 * Requires lychee to be installed: https://lychee.cli.rs/installation/
 *   - cargo install lychee
 *   - or: brew install lychee
 *   - or: choco install lychee
 *
 * Usage:
 *   node scripts/check-links.js [options]
 *
 * Options:
 *   --format json    Output in JSON format
 *   --output <file>  Write results to file
 */

const fs = require("fs");
const path = require("path");
const { execSync } = require("child_process");

const BUILD_DIR = path.resolve(__dirname, "../build");
const SITEMAP_PATH = path.join(BUILD_DIR, "sitemap.xml");
const CONFIG_PATH = path.resolve(__dirname, "../lychee.toml");

function extractUrlsFromSitemap(sitemapPath) {
  const xml = fs.readFileSync(sitemapPath, "utf8");
  const urls = [...xml.matchAll(/<loc>([^<]+)<\/loc>/g)].map((m) => m[1]);
  return urls;
}

function urlToLocalPath(url) {
  // https://signalwire.com/docs/platform/getting-started -> build/platform/getting-started/index.html
  const pagePath = url.replace(/^https?:\/\/[^/]+\/docs\/?/, "");
  if (!pagePath) return path.join(BUILD_DIR, "index.html");
  const htmlPath = path.join(BUILD_DIR, pagePath, "index.html");
  if (fs.existsSync(htmlPath)) return htmlPath;
  // Try .html extension
  const altPath = path.join(BUILD_DIR, pagePath + ".html");
  if (fs.existsSync(altPath)) return altPath;
  return null;
}

function main() {
  // Check prerequisites
  if (!fs.existsSync(SITEMAP_PATH)) {
    console.error("Error: build/sitemap.xml not found. Run `yarn build` first.");
    process.exit(1);
  }

  try {
    execSync("lychee --version", { stdio: "pipe" });
  } catch {
    console.error(
      "Error: lychee is not installed.\n" +
      "Install it from: https://lychee.cli.rs/installation/\n" +
      "  cargo install lychee\n" +
      "  brew install lychee\n" +
      "  choco install lychee"
    );
    process.exit(1);
  }

  // Extract URLs from sitemap
  const sitemapUrls = extractUrlsFromSitemap(SITEMAP_PATH);
  console.log(`Found ${sitemapUrls.length} URLs in sitemap.xml`);

  // Convert to local HTML file paths
  const htmlFiles = sitemapUrls
    .map(urlToLocalPath)
    .filter(Boolean);

  console.log(`Resolved ${htmlFiles.length} local HTML files`);

  if (htmlFiles.length === 0) {
    console.error("Error: No HTML files found from sitemap URLs.");
    process.exit(1);
  }

  // Write file list for lychee --files-from (relative paths from project root)
  const projectRoot = path.resolve(__dirname, "..");
  const fileListPath = path.join(BUILD_DIR, ".lychee-inputs.txt");
  fs.writeFileSync(
    fileListPath,
    htmlFiles
      .map((f) => path.relative(projectRoot, f).replace(/\\/g, "/"))
      .join("\n")
  );

  const args = process.argv.slice(2);
  const extraArgs = args.length ? " " + args.join(" ") : "";

  const fwd = (p) => p.replace(/\\/g, "/");
  const cmd =
    `lychee --config "${fwd(CONFIG_PATH)}" --root-dir "${fwd(BUILD_DIR)}"${extraArgs} --files-from "${fwd(fileListPath)}"`;


  console.log(`Running lychee on ${htmlFiles.length} pages...\n`);

  try {
    execSync(cmd, { stdio: "inherit" });
    console.log("\nAll links OK!");
  } catch (e) {
    process.exit(e.status || 1);
  } finally {
    if (fs.existsSync(fileListPath)) fs.unlinkSync(fileListPath);
  }
}

main();
