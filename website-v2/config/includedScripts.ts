/**
 * Configuration for the site's included scripts.
 *
 * Used by: docusaurus.config.ts
 * Within: config.scripts
 *
 * Docusaurus technical reference: https://docusaurus.io/docs/api/docusaurus-config#scripts
 */

import type { Config } from "@docusaurus/types";

type ScriptItem = NonNullable<Config["scripts"]>[number];

const scripts: ScriptItem[] = [
  {
    src: "/scripts/fullstory.js",
    async: true,
    nonce: "SIGNALWIRE_DOCS_CSP_NONCE",
  },
  {
    src: "/scripts/hubspot.js",
  },
  {
    src: "/scripts/zoomInfo.js",
    async: true,
    nonce: "SIGNALWIRE_DOCS_CSP_NONCE",
  },
  {
    src: "/scripts/noticeable-bar.js",
    async: true,
    nonce: "SIGNALWIRE_DOCS_CSP_NONCE",
  },
];

export default scripts;
