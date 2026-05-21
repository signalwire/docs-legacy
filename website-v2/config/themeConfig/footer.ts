/**
 * Configuration for the site's footer.
 *
 * Used by: docusaurus.config.ts
 * Within: config.themeConfig.footer
 *
 * Docusaurus technical reference: https://docusaurus.io/docs/api/themes/configuration#footer
 */

import type { Footer } from '@docusaurus/theme-common';

const footer = {
  style: "dark" as const,
  links: [
    {
      title: "Company",
      items: [
        {
          label: "About Us",
          href: "https://signalwire.com/company/about-us",
        },
        {
          label: "Blog",
          href: "https://signalwire.com/company/blog",
        },
        {
          label: "Contact Us",
          href: "https://signalwire.com/company/contact",
        },
        {
          label: "Home",
          href: "https://signalwire.com",
        },
        {
          label: "Legal",
          href: "https://signalwire.com/legal/signalwire-cloud-agreement",
        },
        {
          label: "Privacy Policy",
          href: "https://signalwire.com/legal/privacy-policy",
        },
        {
          label: "Security",
          href: "https://signalwire.com/legal/security",
        },
      ],
    },
    {
      title: "Community",
      items: [
        {
          label: "Stack Overflow",
          href: "https://stackoverflow.com/questions/tagged/signalwire",
        },
        {
          label: "Discord",
          href: "https://discord.com/invite/F2WNYTNjuF",
        },
      ],
    },
    {
      title: "More",
      items: [
        {
          label: "GitHub",
          href: "https://github.com/signalwire",
        },
      ],
    },
    {
      title: "Pricing",
      items: [
        {
          label: "AI Agent",
          href: "https://signalwire.com/pricing/ai-agent-pricing",
        },
        {
          label: "Messaging",
          href: "https://signalwire.com/pricing/messaging",
        },
        {
          label: "Voice",
          href: "https://signalwire.com/pricing/voice",
        },
        {
          label: "Video",
          href: "https://signalwire.com/pricing/video",
        },
        {
          label: "Fax",
          href: "https://signalwire.com/pricing/fax",
        },
        {
          label: "Number Lookup",
          href: "https://signalwire.com/pricing/lookup",
        },
        {
          label: "Integrations",
          href: "https://signalwire.com/pricing",
        },
        {
          label: "MFA",
          href: "https://signalwire.com/pricing/mfa-api-pricing",
        },
      ],
    },
  ],
  copyright: `Copyright © ${new Date().getFullYear()} SignalWire Inc.`,
} satisfies Footer;

export default footer; 