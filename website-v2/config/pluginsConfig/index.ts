/*
 * This file is used to configure the plugins for the site.
 *
 * Used by: docusaurus.config.js
 * Within: config
 *
 *
 * All plugin options can be modified at the corresponding plugin file.
 *
 * Example: openapi plugin options can be modified at the /config/pluginsConfig/openapi.ts file.
 *
 * Docusaurus technical reference: https://docusaurus.io/docs/api/docusaurus-config#plugins
 */

import { PluginConfig } from "@docusaurus/types";
import { openapiPlugin } from "./docusaurus-plugin-openapi-docs";
import { sassPlugin } from "./sass";
import { llmsTxtPlugin } from "./docusaurus-plugin-llms-txt";
import { realtimeSdkPlugin } from "./realtime-sdk-docs";
import { browserSdkPlugin } from "./browser-sdk-docs";
import { agentsSdkManualPlugin } from "./agents-sdk-docs";
// import { signalwireSdkPlugin } from "./signalwire-client-sdk-docs";

const plugins: PluginConfig[] = [
  openapiPlugin,
  sassPlugin,
  require.resolve("../../src/plugins/docusaurus-plugin-image-alias"),
  ["plugin-image-zoom", {}],
  llmsTxtPlugin,
  realtimeSdkPlugin,
  browserSdkPlugin,
  agentsSdkManualPlugin,
  // signalwireSdkPlugin,
];

export default plugins;
