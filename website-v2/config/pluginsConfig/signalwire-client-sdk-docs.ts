import { PluginConfig, PluginOptions } from "@docusaurus/types";
import sidebarGenerator from "../../src/plugins/SidebarGenerator";

export const signalwireSdkPlugin: PluginConfig = [
  "@docusaurus/plugin-content-docs",
  {
    id: "signalwire-client-sdk",
    path: "docs/signalwire-client-sdk",
    routeBasePath: "sdks/signalwire-client-sdk",
    sidebarPath: require.resolve("../sidebarsConfig/signalwire-client-sdk/index.ts"),
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
        label: "v0",
        banner: "none",
      },
    },
  } satisfies PluginOptions,
];
