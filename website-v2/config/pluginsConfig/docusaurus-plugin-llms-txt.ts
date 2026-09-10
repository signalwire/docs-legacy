/*
* This plugin is used to collect all markdown files that are included in the config.
* The Markdown files are then printed into a single file and saved in the static/attachments folder.
* 
* This plugin was written by the SignalWire DevEx team, and its code is hosted within this repository.
* 
* The plugin can be found at the following file path: ./plugins/markdown-printer
*/

import { PluginConfig } from '@docusaurus/types';
import type { Options as PluginOptions } from '@signalwire/docusaurus-plugin-llms-txt';
import rehypeTransformApiField from './rehype-transform-apifield';

export const llmsTxtPlugin: PluginConfig = [
  "@signalwire/docusaurus-plugin-llms-txt",
  {
    // Top-level runtime options
    logLevel: 1,
    onRouteError: 'throw',
    onSectionError: 'throw',
    runOnPostBuild: true,

    // Markdown file generation options
    markdown: {
      enableFiles: true,
      relativePaths: true,
      includeDocs: true,
      includeVersionedDocs: false,
      includeBlog: false,
      includePages: false,
      includeGeneratedIndex: false,
      beforeDefaultRehypePlugins: [
        rehypeTransformApiField
      ],
      remarkStringify: {
        rule: '-',
        ruleRepetition: 3
      },
      excludeRoutes: [
        "/attachments/**",
        "/cluecon-2024/**",
        "/img/**",
        "/demos/**",
        "/tags/**",
        "/plugins/**",
        "/internal/**",
        "/landing-assets/**",
        "/livewire/**",
        "/events/**",
        "/assets/**",
        "/404.html",
        "/media/**",
        "/search",
        "/",
        '/apis/*/**',
        '/compatibility-api/rest/**'
      ],
    },

    // llms.txt index file options
    llmsTxt: {
      autoSectionPosition: 3,
      enableLlmsFullTxt: true,
      includeDocs: true,
      includeVersionedDocs: false,
      includeBlog: false,
      includePages: false,
      includeGeneratedIndex: false,
      excludeRoutes: [
        "/attachments/**",
        "/cluecon-2024/**",
        "/img/**",
        "/demos/**",
        "/tags/**",
        "/plugins/**",
        "/internal/**",
        "/landing-assets/**",
        "/livewire/**",
        "/events/**",
        "/assets/**",
        "/404.html",
        "/media/**",
        "/search",
        "/",
        '/apis/*/**',
        '/compatibility-api/rest/**'
      ],

      enableDescriptions: true,
      siteTitle: "SignalWire Developer Documentation",
      siteDescription: "SignalWire provide comprehensive and easy to use APIs that allow developers to create unified communication applications.",

      optionalLinks: [
        {
          title: "Support",
          url: "https://support.signalwire.com",
          description: "SignalWire Support"
        }
      ],

      sections: [
        {
          id: 'swml',
          name: 'SWML Documentation',
          description: 'The SignalWire Markup Language which allows developers to create communication applications with simple JSON & YAML documents.',
          position: 0,
          routes: [
            {
              route: '/swml/**'
            }
          ],
          attachments: [
            {
              fileName: 'swml-json-schema',
              title: 'SWML JSON Schema',
              description: "The JSON Schema definition for SWML (SignalWire Markup Language).",
              source: '../specs/swml/tsp-output/@typespec/json-schema/SWMLObject.json',
            }
          ],
        },
        {
          id: 'sdks',
          name: 'SDKs',
          description: 'SignalWire Software Development Kits for building real-time communication applications.',
          position: 1,
          routes: [
            {
              route:  '/sdks/**'
            }
          ],
          subsections: [
            {
              id: 'agents-sdk',
              name: 'Agents SDK',
              description: 'Build AI-powered voice and messaging applications with the SignalWire Agents SDK.',
              routes: [
                {
                  route: '/sdks/agents-sdk/**'
                }
              ]
            },
            {
              id: 'browser-sdk',
              name: 'Browser SDK',
              description: 'Build WebRTC-based applications with the SignalWire Browser SDK.',
              routes: [
                {
                  route: '/sdks/browser-sdk/**'
                }
              ]
            },
            {
              id: 'realtime-sdk',
              name: 'Realtime SDK',
              description: 'Build real-time communication applications from your backend with the SignalWire Realtime SDK.',
              routes: [
                {
                  route: '/sdks/realtime-sdk/**'
                }
              ]
            }
          ]
        },
        {
          id: 'api-ref',
          name: 'API OpenAPI Spec',
          description: 'The OpenAPI Spec definitions.',
          position: 2,
          routes: [
            {
              route: '/apis/**'
            }
          ],
          attachments: [
            {
              fileName: 'compatibility-api',
              source: '../specs/compatibility-api/_spec_.yaml',
              title: 'Compatibility API Spec',
              description: "The OpenAPI spec for the SignalWire Compatibility API.",
            },
            {
              fileName: 'calling-api',
              source: '../specs/signalwire-rest/calling-api/tsp-output/@typespec/openapi3/openapi.yaml',
              title: 'Calling API Spec',
              description: "The OpenAPI spec for the SignalWire Calling API.",
            },
            {
              fileName: 'chat-api',
              source: '../specs/signalwire-rest/chat-api/tsp-output/@typespec/openapi3/openapi.yaml',
              title: 'Chat API Spec',
              description: "The OpenAPI spec for the SignalWire Chat API.",
            },
            {
              fileName: 'data-sphere-api',
              source: '../specs/signalwire-rest/datasphere-api/tsp-output/@typespec/openapi3/openapi.yaml',
              title: 'DataSphere API Spec',
              description: "The OpenAPI spec for the SignalWire DataSphere API.",
            },
            {
              fileName: 'fabric-api',
              source: '../specs/signalwire-rest/fabric-api/tsp-output/@typespec/openapi3/openapi.yaml',
              title: 'Fabric API Spec',
              description: "The OpenAPI spec for the SignalWire Fabric API.",
            },
            {
              fileName: 'fax-api',
              source: '../specs/signalwire-rest/fax-api/tsp-output/@typespec/openapi3/openapi.yaml',
              title: 'Fax API Spec',
              description: "The OpenAPI spec for the SignalWire Fax API.",
            },
            {
              fileName: 'logs-api',
              source: '../specs/signalwire-rest/logs-api/tsp-output/@typespec/openapi3/openapi.yaml',
              title: 'Logs API Spec',
              description: "The OpenAPI spec for the SignalWire Logs API.",
            },
            {
              fileName: 'message-api',
              source: '../specs/signalwire-rest/message-api/tsp-output/@typespec/openapi3/openapi.yaml',
              title: 'Message API Spec',
              description: "The OpenAPI spec for the SignalWire Message API.",
            },
            {
              fileName: 'pubsub-api',
              source: '../specs/signalwire-rest/pubsub-api/tsp-output/@typespec/openapi3/openapi.yaml',
              title: 'PubSub API Spec',
              description: "The OpenAPI spec for the SignalWire PubSub API.",
            },
            {
              fileName: 'voice-api',
              source: '../specs/signalwire-rest/voice-api/tsp-output/@typespec/openapi3/openapi.yaml',
              title: 'Voice API Spec',
              description: "The OpenAPI spec for the SignalWire Voice API.",
            }
          ]
        },
      ],
    },

    // UI options
    ui: {
      copyPageContent: {
        contentStrategy: 'prefer-markdown',
        display: {
          excludeRoutes: [
            '/apis/*/**',
            '/compatibility-api/rest/**',
            '/'
          ]
        }
      }
    }
  } satisfies PluginOptions
];