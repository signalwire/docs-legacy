import type { Options } from "@docusaurus/preset-classic";
import type { PresetConfig } from "@docusaurus/types";
import sidebarGenerator from "../src/plugins/SidebarGenerator";

/**
 * Configuration for the site's presets.
 *
 * Used by: docusaurus.config.js
 * Within: config.presets
 *
 * Docusaurus technical reference: https://docusaurus.io/docs/using-plugins#using-presets
 */

const presets: PresetConfig[] = [
  [
    "classic",
    {
      docs: {
        editUrl: "https://github.com/signalwire/docs/edit/main/website",
        path: "docs/main",
        routeBasePath: "/",
        sidebarPath: require.resolve("./sidebarsConfig/main/index.ts"),
        docItemComponent: "@theme/ApiItem",
        sidebarItemsGenerator: sidebarGenerator,
        showLastUpdateTime: false,
        remarkPlugins: [
          [require("@docusaurus/remark-plugin-npm2yarn"), { sync: true }],
        ],
        beforeDefaultRemarkPlugins: [
          [require("../src/plugins/remark-plugin-image-to-figure"), {}],
        ],
        tags: "tags.yml",
        onInlineTags: "warn",
      },
      blog: false,
      theme: {
        customCss: require.resolve("../src/css/index.scss"),
      },
      gtag: process.env.GTAG
        ? {
            trackingID: process.env.GTAG,
          }
        : undefined,
    } satisfies Options,
  ],
];

export default presets;
