import type { Config } from '@docusaurus/types';
import type { ThemeConfig } from '@docusaurus/preset-classic';
import dotenv from "dotenv";
import branding from "./config/branding"; // Imports all branding options from the /config/branding.ts file.
import scripts from "./config/includedScripts";
import presets from "./config/presets";
import plugins from "./config/pluginsConfig";
import typesense from "./config/typesense";
import stylesheets from "./config/stylesheets";
import themeConfig from "./config/themeConfig/config";

dotenv.config({ path: '../.env' }); // Imports environment variables from the .env file in the root of the project.

const config: Config = { 


  future: {
    v4: true,
    experimental_faster: true
  },

  markdown: {
    mermaid: true, // enables mermaid diagrams in markdown files
    hooks: {
      onBrokenMarkdownImages: 'throw',
      onBrokenMarkdownLinks: 'throw'
    }
  },

  themes: [
    '@signalwire/docusaurus-theme-llms-txt',
    "@docusaurus/theme-mermaid", // Imports the mermaid library for rendering diagrams
    "docusaurus-theme-openapi-docs", // Imports the openapi-docs theme for rendering OpenAPI documentation
    ...(process.env.TYPESENSE_HOST && process.env.TYPESENSE_API_SEARCH_KEY && process.env.TYPESENSE_COLLECTION_NAME && (process.env.TYPESENSE_PORT || process.env.TYPESENSE_EXPORTS) ?
      ["docusaurus-theme-search-typesense"] : []), // Only include Typesense theme if env vars are set
  ],

  // All branding options can be modified at the /config/branding.ts file.
  title: branding.title,
  url: branding.url,
  baseUrl: branding.baseUrl ?? "/",
  favicon: branding.favicon ?? "/favicon.ico", 

  /*  Errors are thrown if broken links, markdown links, anchors, or duplicate routes are found.
      This is useful for catching errors during development.
      More information can be found at: https://docusaurus.io/docs/api/docusaurus-config
  */
  onBrokenLinks: "throw",
  onBrokenAnchors: "throw",
  onDuplicateRoutes: "throw",

  i18n: {
    defaultLocale: "en-US", // Sets useful metadata for the site, such as HTML lang attribute.
    locales: ["en-US"],
  },

  presets: presets, // All preset options can be modified at the /config/presets.js file.
  plugins: plugins, // plugins of the site. All plugin options can be modified at the /config/pluginsConfig/index.ts file.
  
  
  themeConfig: {
    navbar: branding.navbar, // navbar of the site
    typesense: typesense, // typesense configuration
    ...themeConfig,
  } satisfies ThemeConfig,

  stylesheets: stylesheets, // stylesheets of the site. All stylesheet options can be modified at the /config/stylesheets.js file.
  scripts: scripts, // scripts of the site. All script options can be modified at the /config/includedScripts.ts file.
};

export default config; 