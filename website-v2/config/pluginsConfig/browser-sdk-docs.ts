import { PluginConfig, PluginOptions } from "@docusaurus/types";
import sidebarGenerator from "../../src/plugins/SidebarGenerator";


export const browserSdkPlugin: PluginConfig = [
  "@docusaurus/plugin-content-docs",
  {
    id: "browser-sdk",
    path: "docs/browser-sdk",
    routeBasePath: "browser-sdk",
    sidebarPath: require.resolve("../sidebarsConfig/browser-sdk/index.ts"),
    editUrl: "https://github.com/signalwire/docs/edit/main/website",
    editCurrentVersion: true,
    docItemComponent: "@theme/ApiItem",
    sidebarItemsGenerator: sidebarGenerator,
    remarkPlugins: [
      [require("@docusaurus/remark-plugin-npm2yarn"), { sync: true }],
    ],
    beforeDefaultRemarkPlugins: [
      [require("../../src/plugins/remark-plugin-image-to-figure"), {}],
    ],
    lastVersion: "current",
    versions: {
      current: {
        label: "v3",
        banner: 'none'
      },
      "v2": {
        label: "v2",
        banner: 'none'
      }
    },
  } satisfies PluginOptions,
];