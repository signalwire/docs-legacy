import React from 'react';
import Link from '@docusaurus/Link';
import clsx from 'clsx';
import DropdownNavbarItem from '@theme/NavbarItem/DropdownNavbarItem';
import { useSecondaryNavState } from '@theme/Navbar/hooks/useSecondaryNavState';
import { ProductLink, DropdownItem } from '@site/secondaryNavbar';
import { createDropdownItemHtml } from '@theme/utils/productUtils';
import styles from './styles.module.scss';

export default function SecondaryNavbar(): React.JSX.Element | null {
  // Get secondary navbar state from shared hook
  const { product, productLinks, activeSidebar } = useSecondaryNavState();

  // Don't render if no product links or only 1 item
  if (!productLinks || productLinks.length <= 1) {
    return null;
  }

  return (
    <div className={clsx('navbar', 'navbar--secondary', styles.secondaryNavbar)}>
      <div className="navbar__inner">
        {/* LEFT CONTAINER - Product navigation links */}
        <div className="theme-layout-navbar-left navbar__items">
          {productLinks.map((item: ProductLink, index: number) => {
            if (item.dropdown) {
              // Check if any dropdown child is currently active
              const isParentActive = item.dropdown.some(
                (child) => child.sidebar === activeSidebar
              );

              // Dropdown link - pure container, no link on parent
              return (
                <DropdownNavbarItem
                  mobile={false}
                  key={index}
                  label={item.label}
                  // No 'to' prop - dropdown parents are pure containers
                  className={isParentActive ? 'navbar__link--active' : undefined}
                  items={item.dropdown.map((subItem: DropdownItem) => {
                    // Determine if this dropdown item is active
                    const isSubItemActive = activeSidebar === subItem.sidebar;

                    // If description exists, use html property for structured content
                    if (subItem.description) {
                      return {
                        type: 'default' as const,
                        html: createDropdownItemHtml(subItem.label, subItem.description),
                        to: subItem.link,
                        className: 'dropdown-link-with-description',
                        activeClassName: isSubItemActive ? 'dropdown__link--active' : undefined,
                      };
                    }
                    // Otherwise, use regular label (backward compatible)
                    return {
                      type: 'default' as const,
                      label: subItem.label,
                      to: subItem.link,
                      activeClassName: isSubItemActive ? 'dropdown__link--active' : undefined,
                    };
                  })}
                />
              );
            }

            // Regular link - TypeScript knows item.link is required here
            const isActive = activeSidebar && item.sidebar === activeSidebar;

            return (
              <Link
                key={index}
                to={item.link} // Required - TypeScript enforces this for regular links
                className={clsx(
                  'navbar__item navbar__link',
                  isActive && 'navbar__link--active' // Infima active class (color, no underline)
                )}
              >
                {item.label}
              </Link>
            );
          })}
        </div>
        {/* RIGHT CONTAINER - Empty for now, ready for future right-aligned items */}
        <div className="theme-layout-navbar-right navbar__items navbar__items--right">
        </div>
      </div>
    </div>
  );
}
