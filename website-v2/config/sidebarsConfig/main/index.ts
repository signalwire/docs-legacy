/**
 * Main docs instance sidebar configurations
 *
 * Auto-generated from Fern YAML navigation files.
 * Run: node scripts/generate-sidebars-from-fern.js
 */

import type { SidebarsConfig } from "@docusaurus/plugin-content-docs";
import homeSidebar from "./home-sidebar";
import platformSidebars from "./platform-sidebar";
import swmlSidebars from "./swml-sidebar";
import callFlowBuilderSidebar from "./call-flow-builder-sidebar";
import restApiSidebars from "./rest-api-sidebar";
import compatibilityApiSidebars from "./compatibility-api-sidebar";

const mainSidebars: SidebarsConfig = {
  ...homeSidebar,
  ...platformSidebars,
  ...swmlSidebars,
  ...callFlowBuilderSidebar,
  ...restApiSidebars,
  ...compatibilityApiSidebars,
};

export default mainSidebars;
