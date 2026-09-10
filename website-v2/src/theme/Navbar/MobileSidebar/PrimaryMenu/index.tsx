import React, { useState, useRef, type ReactNode } from 'react';
import { useNavbarMobileSidebar } from '@docusaurus/theme-common/internal';
import { useWindowSize } from '@docusaurus/theme-common';
import Link from '@docusaurus/Link';
import NavbarItem from '@theme/NavbarItem';
import DropdownNavbarItem from '@theme/NavbarItem/DropdownNavbarItem';
import { useSecondaryNavState } from '@theme/Navbar/hooks/useSecondaryNavState';
import { useNavbarItems } from '@theme/utils/productUtils';
import styles from './styles.module.scss';

// The primary menu displays the navbar items
export default function NavbarMobilePrimaryMenu(): ReactNode {
  const mobileSidebar = useNavbarMobileSidebar();
  const items = useNavbarItems();
  const windowSize = useWindowSize();

  // Get secondary navbar state
  const { product, productLinks, activeSidebar } = useSecondaryNavState();

  // Track if user manually navigated to main menu
  const userNavigatedToMainRef = useRef(false);

  // Internal state: toggle between main menu and secondary navbar
  const [showMainNav, setShowMainNav] = useState(true);

  // Wrapper functions to track manual navigation
  const navigateToMain = () => {
    userNavigatedToMainRef.current = true;
    setShowMainNav(true);
  };

  const navigateToSecondary = () => {
    userNavigatedToMainRef.current = false;
    setShowMainNav(false);
  };

  const isMobile = windowSize === 'mobile';

  // If no product or only 1 link, show main menu only (no dual-panel needed)
  if (!product || !productLinks || productLinks.length <= 1) {
    return (
      <ul className="menu__list">
        {items.map((item, i) => (
          <NavbarItem
            mobile
            {...item}
            onClick={() => mobileSidebar.toggle()}
            key={i}
          />
        ))}
      </ul>
    );
  }

  // Mobile: Simple single menu with product nav at top, main items at bottom
  if (isMobile) {
    return (
      <ul className="menu__list">
        {/* Product section divider */}
        <li className="menu__list-item">
          <span className={`menu__link menu__link--sublist ${styles.sectionTitle}`}>
            {product.title}
          </span>
        </li>

        {/* Secondary navbar items */}
        {productLinks.map((navItem, index) => {
          if (navItem.dropdown && navItem.dropdown.length > 0) {
            return (
              <DropdownNavbarItem
                mobile={true}
                key={`secondary-${index}`}
                label={navItem.label}
                items={navItem.dropdown.map((subItem) => ({
                  type: 'default' as const,
                  label: subItem.label,
                  to: subItem.link,
                }))}
              />
            );
          }

          const isActive = activeSidebar && navItem.sidebar === activeSidebar;
          return (
            <li key={`secondary-${index}`} className="menu__list-item">
              <Link
                className={`menu__link ${isActive ? 'menu__link--active' : ''}`}
                to={navItem.link}
                onClick={() => mobileSidebar.toggle()}
              >
                {navItem.label}
              </Link>
            </li>
          );
        })}

        {/* Separator between product nav and main nav */}
        <li className={`menu__list-item ${styles.menuSeparator}`} />

        {/* Main navbar items */}
        {items.map((item, i) => (
          <NavbarItem
            mobile
            {...item}
            onClick={() => mobileSidebar.toggle()}
            key={i}
          />
        ))}
      </ul>
    );
  }

  // Dual-panel mode: render both main menu and secondary navbar with transitions
  return (
    <div className={`${styles.menuContainer} ${!showMainNav ? styles.showSecondary : ''}`}>
      {/* Main Menu Panel */}
      <ul className={`menu__list ${styles.menuPanel}`}>
        {items.map((item, i) => (
          <NavbarItem
            mobile
            {...item}
            onClick={() => mobileSidebar.toggle()}
            key={i}
          />
        ))}
      </ul>

      {/* Secondary Navbar Panel */}
      <ul className={`menu__list ${styles.menuPanel}`}>
        {/* Back to main menu button */}
        <li className="menu__list-item">
          <button
            type="button"
            className="clean-btn navbar-sidebar__back"
            onClick={navigateToMain}
          >
            ← Back to main menu
          </button>
        </li>

        {/* Product section title */}
        <li className="menu__list-item">
          <span className={`menu__link menu__link--sublist ${styles.sectionTitle}`}>
            {product.title}
          </span>
        </li>

        {/* Secondary navbar links */}
        {productLinks.map((navItem, index) => {
          if (navItem.dropdown && navItem.dropdown.length > 0) {
            return (
              <DropdownNavbarItem
                mobile={true}
                key={index}
                label={navItem.label}
                items={navItem.dropdown.map((subItem) => ({
                  type: 'default' as const,
                  label: subItem.label,
                  to: subItem.link,
                }))}
              />
            );
          }

          const isActive = activeSidebar && navItem.sidebar === activeSidebar;
          return (
            <li key={index} className="menu__list-item">
              <Link
                className={`menu__link ${isActive ? 'menu__link--active' : ''}`}
                to={navItem.link}
                onClick={() => mobileSidebar.toggle()}
              >
                {navItem.label}
              </Link>
            </li>
          );
        })}
      </ul>
    </div>
  );
}
