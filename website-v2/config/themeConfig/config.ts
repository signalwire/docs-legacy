/**
 * Configuration for the site's theme.
 *
 * Used by: docusaurus.config.ts
 * Within: config.themeConfig
 *
 * Docusaurus technical reference: https://docusaurus.io/docs/api/themes/configuration
 */

import { themes as PrismThemes } from "prism-react-renderer";
import type { ThemeConfig } from "@docusaurus/preset-classic";
import footerItems from "./footer";


const lightCodeTheme = PrismThemes.github;
const darkCodeTheme = PrismThemes.dracula;

const config: ThemeConfig = {

  footer: footerItems,
  docs: {
    versionPersistence: "localStorage",
    sidebar: {
      autoCollapseCategories: true,
      hideable: true,
    },
  },
  prism: {
    theme: lightCodeTheme,
    darkTheme: darkCodeTheme,
    additionalLanguages: [
      "dart",
      "ocaml",
      "r",
      "php",
      "csharp",
      "ruby",
      "java",
      "ini",
      "bash",
      "json",
      "powershell",
    ],
    magicComments: [
      // We don't care about the className; this is only to make docusaurus filter out the comment.
      {
        className: "prettier-ignore",
        line: "prettier-ignore",
      },
    ],
  },
  colorMode: {
    defaultMode: "dark",
    disableSwitch: false,
    respectPrefersColorScheme: false,
  },

  // Theme configuration for lightbox (plugin-image-zoom)
  imageZoom: {
    selector: ".lightbox img, img.lightbox",
    options: {
      margin: 80,
      scrollOffset: 0,
    },
  },

  /* Announcement bar configuration
  announcementBar: {
    id: 'cluecon_2025', // Unique ID for ClueCon announcement
    content: '🎉 Join us at ClueCon 2025: A Developer Conference | August 4-7, 2025 | WebRTC, AI & Telephony | <a href="https://www.cluecon.com/" target="_blank" rel="noopener noreferrer">Learn More & Register</a>',
    isCloseable: true, // Allow users to close the announcement
  },
  */
};

export default config;
