/**
 * Configuration for the site's Typesense.
 *
 * Used by: docusaurus.config.ts
 * Within: config.themeConfig.typesense
 *
 * Typesense technical reference: https://typesense.org/docs/0.24.0/api/search.html#search-parameters
 */

import dotenv from "dotenv";
import type { ThemeConfig } from "docusaurus-theme-search-typesense";
import type { ConfigurationOptions } from "typesense/lib/Typesense/Configuration";
import type { SearchParams } from "typesense/lib/Typesense/Documents";

// Load environment variables
dotenv.config({ path: '../.env' });

const config: NonNullable<ThemeConfig["typesense"]> = {
  typesenseCollectionName: process.env.TYPESENSE_COLLECTION_NAME ?? "placeholder",

  typesenseServerConfig: {
    nodes: [
      {
        host: process.env.TYPESENSE_HOST ?? "example.typesense.com",
        protocol: (process.env.TYPESENSE_PROTOCOL as "http" | "https") ?? "https",
        port: Number(process.env.TYPESENSE_EXPORTS) ?? 8108,
      },
    ],
    apiKey: process.env.TYPESENSE_API_SEARCH_KEY ?? "placeholder",
  } satisfies ConfigurationOptions,

  typesenseSearchParameters: {
    query_by:
      "hierarchy.lvl0,hierarchy.lvl1,hierarchy.lvl2,hierarchy.lvl3,hierarchy.lvl4,hierarchy.lvl5,hierarchy.lvl6,content,embedding",
    vector_query: "embedding:([], k: 5, distance_threshold: 1.0, alpha: 0.2)",
  } satisfies SearchParams,
  contextualSearch: true,
  searchPagePath: "/search",
};

export default config;
