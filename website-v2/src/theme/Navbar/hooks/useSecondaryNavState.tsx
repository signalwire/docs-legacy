import { useMemo } from 'react';
import { useLocation } from '@docusaurus/router';
import { useActivePluginAndVersion, useActiveDocContext } from '@docusaurus/plugin-content-docs/client';
import { ProductItem, ProductLink } from '@site/secondaryNavbar';
import { useAllProducts, detectCurrentProduct, detectCurrentProductBySidebar } from '@theme/utils/productUtils';

export function useSecondaryNavState() {
  const location = useLocation();
  const activePluginAndVersion = useActivePluginAndVersion();
  const activeVersion = activePluginAndVersion?.activeVersion?.name;

  // Get the active document's sidebar name
  const activeDocContext = useActiveDocContext(activePluginAndVersion?.activePlugin?.pluginId);
  const activeSidebar = activeDocContext?.activeDoc?.sidebar;

  // Get flat map of all products from shared utility
  const allProducts = useAllProducts();

  // Detect current product based on sidebar first (most reliable), then pathname
  const currentProduct = useMemo(() => {
    // Try sidebar-based detection first (most reliable)
    if (activeSidebar) {
      const productBySidebar = detectCurrentProductBySidebar(activeSidebar, allProducts);
      if (productBySidebar) return productBySidebar;
    }

    // Fallback to URL matching for non-doc pages (blog, home, etc.)
    return detectCurrentProduct(location.pathname, allProducts);
  }, [activeSidebar, location.pathname, allProducts]);

  const product: ProductItem | null = currentProduct ? allProducts[currentProduct] : null;

  // Get version-specific links
  const productLinks = useMemo<ProductLink[]>(() => {
    if (!product) return [];

    if (product.versions && activeVersion) {
      return product.versions[activeVersion]?.links || [];
    }

    return product.links || [];
  }, [product, activeVersion]);

  return { currentProduct, product, productLinks, activeSidebar };
}
