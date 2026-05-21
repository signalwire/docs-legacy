import { PluginConfig, PluginOptions } from "@docusaurus/types";
import sidebarGenerator from "../../src/plugins/SidebarGenerator";


export const realtimeSdkPlugin: PluginConfig = [
  "@docusaurus/plugin-content-docs",
  {
    id: "realtime-sdk",
    path: "docs/realtime-sdk",
    routeBasePath: "server-sdk",
    sidebarPath: require.resolve("../sidebarsConfig/realtime-sdk/index.ts"),
    editUrl: "https://github.com/signalwire/docs/edit/main/website",
    editCurrentVersion: true,
    breadcrumbs: true,
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
        label: "v4",
        banner: 'none'
      },
      "v3": {
        label: "v3",
        banner: 'none'
      },
      "v2": {
        label: "v2",
        banner: 'unmaintained'
      }
    },
    tags: "tags.yml",
    onInlineTags: "throw",
  } satisfies PluginOptions,
];