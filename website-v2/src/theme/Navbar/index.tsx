import React, { type ReactNode, useState } from 'react';
import NavbarLayout from '@theme/Navbar/Layout';
import NavbarContent from '@theme/Navbar/Content';
import SecondaryNavbar from '@theme/SecondaryNavbar';
import ProductModal from '@theme/ProductModal';
import { ModalContext } from '@theme/Navbar/ModalContext';

export default function Navbar(): ReactNode {
  const [isModalOpen, setModalOpen] = useState(false);
  const [currentProduct, setCurrentProduct] = useState<string | null>(null);

  return (
    <ModalContext.Provider value={{ isModalOpen, setModalOpen, currentProduct, setCurrentProduct }}>
      <div
        style={{
          position: 'sticky',
          top: 0,
          zIndex: 'var(--ifm-z-index-fixed)',

        }}
      >
        <NavbarLayout>
          <NavbarContent />
        </NavbarLayout>
        <SecondaryNavbar />
      </div>
      <ProductModal
        isOpen={isModalOpen}
        onClose={() => setModalOpen(false)}
        currentProduct={currentProduct}
      />
    </ModalContext.Provider>
  );
}
