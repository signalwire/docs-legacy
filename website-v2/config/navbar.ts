/**
 * Configuration for the site's navbar.
 *
 * Used by: docusaurus.config.ts
 * Within: config.themeConfig.navbar.items
 *
 * Docusaurus technical reference: https://docusaurus.io/docs/api/themes/configuration#navbar
 */

import type { NavbarItem } from "@docusaurus/theme-common";

const navbar: NavbarItem[] = [
  /* Product Dropdown
  * Custom navbar item for switching between products.
  * Registered via ComponentTypes pattern.
  */
  {
    type: "custom-productDropdown",
    position: "left",
  },

  /* Docs Version Dropdown
  * Conditoinaly renders in if current route has versioned docs.
  * See the VersionDropdown theme component for more details.
  */

  {
    type: "docsVersionDropdown",
    position: "left",
    dropdownActiveClassDisabled: true,
  },

  /// Support Dropdown -------- ///
  {
    type: "dropdown",
    label: "Support",
    position: "right",
    items: [
      {
        href: "https://signalwire.zohodesk.com/portal/en/newticket",
        label: "Create a Ticket",
        "aria-label": "Support",
      },
      {
        href: "https://signalwire.zohodesk.com/portal/en/myarea",
        label: "My Tickets",
        "aria-label": "Support",
      },
      {
        href: "https://status.signalwire.com",
        label: "Platform Status",
        "aria-label": "Platform Status",
      },
    ],
  },

  /// Community Dropdown -------- ///
  {
    to: "https://signalwire.zohodesk.com/portal/en/community",
    label: "Community",
    position: "right",
  },

  /// Platform Dropdown -------- ///
  {
    label: "Platform",
    position: "right",
    type: "dropdown",
    items: [
      {
        href: "https://signalwire.com/signup",
        label: "SignalWire Space (Signup)",
        className: "dashboard-navbar-link",
        "aria-label": "Open SignalWire Dashboard",
      },
      {
        href: "https://status.signalwire.com",
        label: "Platform Status",
        "aria-label": "Platform Status",
      },
    ],
  },

  {
    href: "https://discord.com/invite/F2WNYTNjuF",
    position: "right",
    "aria-label": "Discord server",
    className: "header-discord-link",
  },

  {
    href: "https://github.com/signalwire/docs",
    position: "right",
    className: "header-github-link",
    "aria-label": "GitHub repository",
  },
];

export default navbar;
