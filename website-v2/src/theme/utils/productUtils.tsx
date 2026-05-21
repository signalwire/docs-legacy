import { useMemo } from 'react';
import { useThemeConfig } from '@docusaurus/theme-common';
import { modalSections, ProductItem, ProductLink } from '@site/secondaryNavbar';
import type { Props as NavbarItemConfig } from '@theme/NavbarItem';
import React from 'react';
import clsx from 'clsx';

// Type for icon that can be a component or string
export type IconType = React.ComponentType<{ className?: string }>;

/**
 * Shared utility: Creates a flat map of all products from modalSections
 * Used by: useSecondaryNavState, ProductDropdownNavbarItem
 */
export function useAllProducts(): Record<string, ProductItem> {
  return useMemo(() => {
    return modalSections.reduce<Record<string, ProductItem>>((acc, section) => {
      return { ...acc, ...section.items };
    }, {});
  }, []);
}

/**
 * Shared utility: Gets navbar items from theme config
 * Used by: Navbar/Content, MobileSidebar/PrimaryMenu
 */
export function useNavbarItems(): NavbarItemConfig[] {
  // TODO temporary casting until ThemeConfig type is improved
  return useThemeConfig().navbar.items as NavbarItemConfig[];
}

/**
 * Detects the current product based on pathname by matching against all product links.
 *
 * Algorithm:
 * 1. Collects all links from all products (including versioned products and dropdown items)
 * 2. Sorts by link length (longest first) to match most specific paths first
 * 3. Returns the product key of the first matching link
 *
 * @param pathname - The current pathname to match against
 * @param allProducts - Record of all products to search through
 * @param defaultProduct - Optional default product key to return if no match found
 * @returns The detected product key, or defaultProduct, or null if no match and no default
 *
 * Used by: useSecondaryNavState, ProductDropdownNavbarItem
 */
export function detectCurrentProduct(
  pathname: string,
  allProducts: Record<string, ProductItem>,
  defaultProduct?: string | null
): string | null {
  // Collect all product/link pairs from config
  const allLinks: Array<{ productKey: string; link: string }> = [];

  for (const [productKey, productConfig] of Object.entries(allProducts)) {
    // Collect all links (regular + all versions)
    const allProductLinks: ProductLink[] = [];

    if (productConfig.links) {
      allProductLinks.push(...productConfig.links);
    }

    if (productConfig.versions) {
      // Check ALL versions for URL matching
      for (const version of Object.values(productConfig.versions)) {
        if (version.links) {
          allProductLinks.push(...version.links);
        }
      }
    }

    for (const link of allProductLinks) {
      if (link.link) {
        // Regular link - add it directly
        allLinks.push({ productKey, link: link.link });
      } else if (link.dropdown) {
        // Dropdown link - add all children's links for matching
        for (const dropdownItem of link.dropdown) {
          allLinks.push({ productKey, link: dropdownItem.link });
        }
      }
    }
  }

  // Sort by link length (longest first) to match most specific paths first
  // This prevents "/" from matching everything
  allLinks.sort((a, b) => b.link.length - a.link.length);

  // Find first matching link
  for (const { productKey, link } of allLinks) {
    // Special case: root path should only match exactly
    if (link === '/') {
      if (pathname === '/') {
        return productKey;
      }
      continue; // Skip to next link
    }

    // For all other paths, use startsWith
    if (pathname.startsWith(link)) {
      return productKey;
    }
  }

  // Return default or null if no match found
  return defaultProduct !== undefined ? defaultProduct : null;
}

/**
 * Detects the current product based on the active sidebar ID.
 * This is more reliable than URL pattern matching because:
 * 1. Docusaurus already knows which sidebar is active
 * 2. Sidebar IDs are unique per product section
 * 3. Works correctly with complex URL structures and versions
 *
 * @param activeSidebar - The active sidebar ID from Docusaurus (e.g., "swmlOverviewSidebar")
 * @param allProducts - Record of all products to search through
 * @returns The detected product key, or null if no match found
 */
export function detectCurrentProductBySidebar(
  activeSidebar: string | undefined,
  allProducts: Record<string, ProductItem>
): string | null {
  if (!activeSidebar) return null;

  // Search through all products to find which one has a link with this sidebar
  for (const [productKey, productConfig] of Object.entries(allProducts)) {
    // Collect all links to check (regular links + all version links)
    const allProductLinks: ProductLink[] = [];

    if (productConfig.links) {
      allProductLinks.push(...productConfig.links);
    }

    if (productConfig.versions) {
      // Check ALL versions, not just current
      for (const version of Object.values(productConfig.versions)) {
        if (version.links) {
          allProductLinks.push(...version.links);
        }
      }
    }

    // Check if any link in this product matches the active sidebar
    for (const link of allProductLinks) {
      if (link.sidebar === activeSidebar) {
        return productKey;
      }

      // Check dropdown children
      if (link.dropdown) {
        for (const dropdownItem of link.dropdown) {
          if (dropdownItem.sidebar === activeSidebar) {
            return productKey;
          }
        }
      }
    }
  }

  return null;
}

/**
 * Shared utility: Renders an icon (either as a component or CSS class string)
 * Used by: ProductModal, ProductDropdownNavbarItem
 *
 * @param icon - Icon component or CSS class string
 * @param className - Additional CSS classes to apply
 * @returns Rendered icon element or null
 */
export function renderIcon(
  icon: IconType | string | undefined,
  className: string
): React.JSX.Element | null {
  if (!icon) return null;

  if (typeof icon === 'string') {
    return <i className={clsx(icon, className)} aria-hidden="true" />;
  }

  const IconComponent = icon as IconType;
  return <IconComponent className={className} aria-hidden="true" />;
}

/**
 * Shared utility: Sorts items by their position property
 * Items without position are sorted to the end (treated as Infinity)
 * Used by: ProductModal
 *
 * @param items - Array of items with optional position property
 * @returns New sorted array
 */
export function sortByPosition<T extends { position?: number }>(items: T[]): T[] {
  return [...items].sort((a, b) => {
    const posA = a.position ?? Infinity;
    const posB = b.position ?? Infinity;
    return posA - posB;
  });
}

/**
 * Shared utility: Creates HTML for dropdown items with label and optional description
 * Used by: SecondaryNavbar
 *
 * @param label - Item label
 * @param description - Optional item description
 * @returns HTML string for dropdown item
 */
export function createDropdownItemHtml(label: string, description?: string): string {
  return `
    <span class="dropdown-item-label">${label}</span>
    ${description ? `<span class="dropdown-item-description">${description}</span>` : ''}
  `.trim();
}
