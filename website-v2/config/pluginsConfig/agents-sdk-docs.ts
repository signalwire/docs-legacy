import { PluginConfig, PluginOptions } from "@docusaurus/types";
import sidebarGenerator from "../../src/plugins/SidebarGenerator";

export const agentsSdkManualPlugin: PluginConfig = [
  "@docusaurus/plugin-content-docs",
  {
    id: "agents-sdk-manual",
    path: "docs/agents-sdk",
    routeBasePath: "agents-sdk",
    sidebarPath: require.resolve("../sidebarsConfig/agents-sdk/index.ts"),
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
    tags: "tags.yml",
    onInlineTags: "throw",
  } satisfies PluginOptions,
];
