/**
 * Configuration for the site's branding.
 *
 * Used by: docusaurus.config.js
 * Within: config
 *
 * Docusaurus technical reference: https://docusaurus.io/docs/api/themes/configuration#navbar
 */

import type { Navbar } from "@docusaurus/theme-common";
import navbarItems from "./navbar";

interface BrandingConfig {
  title: string;
  url: string;
  baseUrl: string;
  favicon: string;
  navbar: Navbar;
}

const branding: BrandingConfig = {
  title: "SignalWire Docs", // Set to the title of the site. This is added to the window title.
  url: "https://signalwire.com", // Set to the URL of the site.
  baseUrl: "/docs", // Set to the base URL of the site.
  favicon: "img/favicon.svg", // set in the 'static/img' folder

  navbar: {
    // Read more about the navbar options at: https://docusaurus.io/docs/api/themes/configuration#navbar
    logo: {
      srcDark: "img/logo-dark.svg",
      alt: "SignalWire", // Set to the alt text of the logo.
      src: "img/logo.svg", // set in the 'static/img' folder
      href: "pathname:///docs/", // redirect to the root of the site
      target: "_self", // open in the same tab
    },
    hideOnScroll: false,
    items: navbarItems, // All navbar options can be modified at the /config/navbar.js file.
  },
};

export default branding;
