import React, { useEffect } from 'react';
import { useLocation } from '@docusaurus/router';
import { useWindowSize } from '@docusaurus/theme-common';
import { useActivePluginAndVersion, useActiveDocContext } from '@docusaurus/plugin-content-docs/client';
import clsx from 'clsx';
import { FaChevronDown } from 'react-icons/fa';
import { useModalContext } from '@theme/Navbar/ModalContext';
import { ProductItem } from '@site/secondaryNavbar';
import { useAllProducts, detectCurrentProduct, detectCurrentProductBySidebar, renderIcon } from '@theme/utils/productUtils';
import { useKeyboardShortcut } from '@theme/hooks/useKeyboardShortcut';
import styles from './styles.module.scss';

interface Props {
  mobile?: boolean;
}

export default function ProductDropdownNavbarItem({ mobile = false }: Props): React.JSX.Element | null {
  // Don't render in mobile sidebar
  if (mobile) {
    return null;
  }

  const windowSize = useWindowSize();
  const isMobile = windowSize === 'mobile';
  const { isModalOpen, setModalOpen, setCurrentProduct } = useModalContext();
  const location = useLocation();

  // Get active sidebar for product detection
  const activePluginAndVersion = useActivePluginAndVersion();
  const activeDocContext = useActiveDocContext(activePluginAndVersion?.activePlugin?.pluginId);
  const activeSidebar = activeDocContext?.activeDoc?.sidebar;

  // Get flat map of all products from shared utility
  const allProducts = useAllProducts();

  // Determine current product based on sidebar first, then pathname
  const detectedProduct = React.useMemo(() => {
    // Try sidebar-based detection first (most reliable)
    if (activeSidebar) {
      const productBySidebar = detectCurrentProductBySidebar(activeSidebar, allProducts);
      if (productBySidebar) return productBySidebar;
    }

    // Fallback to URL matching for non-doc pages (blog, home, etc.)
    return detectCurrentProduct(location.pathname, allProducts, null);
  }, [activeSidebar, location.pathname, allProducts]);

  // Update context when detected product changes
  useEffect(() => {
    setCurrentProduct(detectedProduct);
  }, [detectedProduct, setCurrentProduct]);

  const product: ProductItem = detectedProduct
    ? allProducts[detectedProduct]
    : {
        title: "Browse Documentation"
      };

  // Close modal when navigating
  useEffect(() => {
    setModalOpen(false);
  }, [location.pathname, setModalOpen]);

  // Keyboard shortcut: Cmd/Ctrl+U
  useKeyboardShortcut('u', () => setModalOpen((prev: boolean) => !prev), {
    ctrlCmd: true,
    preventDefault: true,
  });

  return (
    <button
      className={clsx(styles.productButton, isMobile && styles.mobile)}
      onClick={() => setModalOpen(true)}
      aria-label="Select product"
      aria-expanded={isModalOpen}
    >
      {renderIcon(product.icon, styles.productIcon)}
      <span className={styles.productTitle}>{product.title}</span>
      <FaChevronDown className={styles.arrowIcon} aria-hidden="true" />
    </button>
  );
}
