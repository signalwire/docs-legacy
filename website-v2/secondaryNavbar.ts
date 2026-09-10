import React from "react";
import { FaHome, FaRobot } from "react-icons/fa";
import { FaGear, FaFileCode, FaDiagramProject, FaBolt, FaCode, FaRightLeft } from "react-icons/fa6";
import { MdWeb } from "react-icons/md";
import { IconType } from "react-icons";

// Modal header title
export const modalHeaderTitle = "Explore the SignalWire Docs";

// Type definitions
export interface DropdownItem {
  label: string;
  link: string;
  sidebar: string; // Required for active state detection
  description?: string; // Optional description shown below the label
}

// Regular link (no dropdown) - link is required
export interface RegularProductLink {
  label: string;
  link: string;
  sidebar: string;
  dropdown?: never; // Must NOT have dropdown
}

// Dropdown link - no link property (parent is pure dropdown container)
export interface DropdownProductLink {
  label: string;
  link?: never; // Must NOT have link - dropdown parents are pure containers
  sidebar: string;
  dropdown: DropdownItem[]; // Required - must have dropdown items
}

// Union type - enforces correct combinations
export type ProductLink = RegularProductLink | DropdownProductLink;

export interface ProductVersion {
  links: ProductLink[];
}

export interface ProductItem {
  title: string;
  icon: IconType | string;
  description?: string;
  link: string;
  links?: ProductLink[];
  versions?: Record<string, ProductVersion>;
  dropdown?: DropdownItem[];
  position?: number;
}

export interface ModalSection {
  type: "main" | "section";
  title?: string;
  items: Record<string, ProductItem>;
  position?: number;
}

// Type-based modal sections structure
export const modalSections: ModalSection[] = [
  {
    type: "main",
    title: "",
    position: 1,
    items: {
      home: {
        title: "Home",
        icon: FaHome,
        description: "Overview and getting started",
        link: "/",
        links: [
          {
            label: "Home",
            sidebar: "homeSidebar",
            link: "/"
          }
        ],
        position: 1,
      },
    },
  },
  {
    type: "main",
    position: 2,
    items: {
      platform: {
        title: "Platform",
        icon: FaGear,
        description: "Dashboard, configuration & administration",
        link: "/platform/getting-started",
        position: 1,
        links: [
          {
            label: "Platform",
            link: "/platform/getting-started",
            sidebar: "platformPlatform",
          },
          {
            label: "Calling",
            link: "/platform/calling",
            sidebar: "platformCalling",
          },
          {
            label: "AI",
            link: "/platform/ai",
            sidebar: "platformAi",
          },
          {
            label: "Messaging",
            link: "/platform/messaging",
            sidebar: "platformMessaging",
          },
          {
            label: "Tools",
            link: "/platform/tools",
            sidebar: "platformTools",
          },
        ],
      },
      swml: {
        title: "SWML",
        icon: FaFileCode,
        description: "Write communication applications, call flows and AI agents",
        link: "/swml",
        position: 2,
        links: [
          {
            label: "Reference",
            link: "/swml",
            sidebar: "swmlReferenceSidebar",
          },
          {
            label: "Guides",
            link: "/swml/guides",
            sidebar: "swmlGuidesSidebar",
          },
        ],
      },
      callFlowBuilder: {
        title: "Call Flow Builder",
        description: "Drag-and-drop call flows and AI agents",
        icon: FaDiagramProject,
        link: "/call-flow-builder",
        position: 3,
        links: [
          {
            label: "Call Flow Builder",
            link: "/call-flow-builder",
            sidebar: "callFlowBuilderSidebar",
          },
        ],
      },
      agentsSdk: {
        title: "Agents SDK",
        icon: FaRobot,
        description: "Build AI-powered voice agents",
        link: "/agents-sdk/python",
        position: 4,
        links: [
          {
            label: "Guides",
            link: "/agents-sdk/python",
            sidebar: "agentsSdkGuidesSidebar",
          },
          {
            label: "Reference",
            link: "/agents-sdk/python/reference/agent-base",
            sidebar: "agentsSdkReferenceSidebar",
          },
        ],
      },
      realtimeSdk: {
        title: "Server SDK",
        icon: FaBolt,
        description: "Control communications in real time from your server",
        link: "/server-sdk/node",
        position: 5,
        versions: {
          // Current/latest version (v4)
          current: {
            links: [
              {
                label: "Reference",
                link: "/server-sdk/node",
                sidebar: "realtimeSdkReferenceSidebar",
              },
              {
                label: "Guides",
                link: "/server-sdk/node/guides",
                sidebar: "realtimeSdkGuidesSidebar",
              },
            ],
          },
          // v3 version
          v3: {
            links: [
              {
                label: "Reference",
                link: "/server-sdk/v3/node",
                sidebar: "realtimeSdkReferenceSidebar",
              },
            ],
          },
          // v2 version
          v2: {
            links: [
              {
                label: "Reference",
                link: "/server-sdk/v2/node/reference",
                sidebar: "realtimeSdkLanguageSidebar",
              },
              {
                label: "Guides",
                link: "/server-sdk/v2/guides/v2-vs-v3",
                sidebar: "realtimeSdkGuidesSidebar",
              },
            ],
          },
        },
      },
      browserSdk: {
        title: "Browser SDK",
        icon: MdWeb,
        description: "Build voice, video and chat applications for the browser",
        link: "/browser-sdk/js",
        position: 6,
        versions: {
          // Current/latest version (v3)
          current: {
            links: [
              {
                label: "Reference",
                link: "/browser-sdk/js",
                sidebar: "browserSdkReferenceSidebar",
              },
              {
                label: "Guides",
                link: "/browser-sdk/js/guides",
                sidebar: "browserSdkGuidesSidebar",
              },
              {
                label: "Click-to-Call",
                link: "/browser-sdk/click-to-call",
                sidebar: "browserSdkClickToCallSidebar",
              },
            ],
          },
          // v2 version
          v2: {
            links: [
              {
                label: "Reference",
                link: "/browser-sdk/v2/js",
                sidebar: "browserSdkReferenceSidebar",
              },
            ],
          },
        },
      },
      restApi: {
        title: "APIs",
        icon: FaCode,
        description: "REST API reference and guides",
        link: "/apis",
        position: 7,
        links: [
          {
            label: "APIs",
            link: "/apis",
            sidebar: "apiSidebar",
          },
        ],
      },
      compatibilityApi: {
        title: "Compatibility API",
        icon: FaRightLeft,
        description: "Migrate your TwiML-based applications to SignalWire with ease",
        link: "/compatibility-api/cxml",
        position: 8,
        links: [
          {
            label: "cXML",
            link: "/compatibility-api/cxml",
            sidebar: "compatibilityApiReferenceSidebar",
          },
          {
            label: "SDKs",
            link: "/compatibility-api/sdks",
            sidebar: "compatibilityApiClientLibrariesSidebar",
          },
          {
            label: "REST API",
            link: "/compatibility-api/rest/compatibility-api",
            sidebar: "apiCompatibilitySidebar",
          },
        ],
      },
    },
  },
];
