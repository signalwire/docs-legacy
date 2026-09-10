/*
* This plugin is used to generate the API reference documentation from OpenAPI specs.
*
* Output directories are structured to match Fern's URL layout:
*   SignalWire APIs: /apis/<api-name>/<endpoint>
*   Compatibility API: /compatibility-api/rest/<endpoint>
*
* Docusaurus technical reference: https://github.com/PaloAltoNetworks/docusaurus-openapi-docs
*/

import { PluginConfig } from "@docusaurus/types";
import type * as OpenApiPlugin from "docusaurus-plugin-openapi-docs";
import {PluginOptions} from "docusaurus-plugin-openapi-docs/src/types"

const sharedSidebarOptions = {
  categoryLinkSource: "tag" as const,
  groupPathsBy: "tag" as const,
};

export const openapiPlugin: PluginConfig = [
  'docusaurus-plugin-openapi-docs',
  {
    id: "api",
    docsPluginId: "classic",
    config: {
      // Compatibility API → /compatibility-api/rest/...
      compatibilityRest: {
        specPath: "specs/compatibility/openapi.yaml",
        outputDir: "docs/main/compatibility-api/rest",
        maskCredentials: false,
        sidebarOptions: sharedSidebarOptions,
      },

      // SignalWire APIs → /apis/<api-name>/...
      signalwireCallingApi: {
        specPath: "specs/calling/openapi.yaml",
        outputDir: "docs/main/apis/calling",
        maskCredentials: false,
        sidebarOptions: sharedSidebarOptions,
      },
      signalwireChatApi: {
        specPath: "specs/chat/openapi.yaml",
        outputDir: "docs/main/apis/chat",
        maskCredentials: false,
        sidebarOptions: sharedSidebarOptions,
      },
      signalwireDatasphereApi: {
        specPath: "specs/datasphere/openapi.yaml",
        outputDir: "docs/main/apis/datasphere",
        maskCredentials: false,
        sidebarOptions: sharedSidebarOptions,
      },
      signalwireFabricApi: {
        specPath: "specs/fabric/openapi.yaml",
        outputDir: "docs/main/apis/fabric",
        maskCredentials: false,
        sidebarOptions: sharedSidebarOptions,
      },
      signalwireFaxApi: {
        specPath: "specs/fax/openapi.yaml",
        outputDir: "docs/main/apis/fax",
        maskCredentials: false,
        sidebarOptions: sharedSidebarOptions,
      },
      signalwireLogsApi: {
        specPath: "specs/logs/openapi.yaml",
        outputDir: "docs/main/apis/logs",
        maskCredentials: false,
        sidebarOptions: sharedSidebarOptions,
      },
      signalwireMessagingApi: {
        specPath: "specs/message/openapi.yaml",
        outputDir: "docs/main/apis/messaging",
        maskCredentials: false,
        sidebarOptions: sharedSidebarOptions,
      },
      signalwireProjectApi: {
        specPath: "specs/project/openapi.yaml",
        outputDir: "docs/main/apis/project",
        maskCredentials: false,
        sidebarOptions: sharedSidebarOptions,
      },
      signalwirePubSubApi: {
        specPath: "specs/pubsub/openapi.yaml",
        outputDir: "docs/main/apis/pubsub",
        maskCredentials: false,
        sidebarOptions: sharedSidebarOptions,
      },
      signalwireRelayRestApi: {
        specPath: "specs/relay-rest/openapi.yaml",
        outputDir: "docs/main/apis/relay-rest",
        maskCredentials: false,
        sidebarOptions: sharedSidebarOptions,
      },
      signalwireVideoApi: {
        specPath: "specs/video/openapi.yaml",
        outputDir: "docs/main/apis/video",
        maskCredentials: false,
        sidebarOptions: sharedSidebarOptions,
      },
      signalwireVoiceApi: {
        specPath: "specs/voice/openapi.yaml",
        outputDir: "docs/main/apis/voice",
        maskCredentials: false,
        sidebarOptions: sharedSidebarOptions,
      },
    } satisfies Record<string, OpenApiPlugin.Options>
  } satisfies PluginOptions,
];
