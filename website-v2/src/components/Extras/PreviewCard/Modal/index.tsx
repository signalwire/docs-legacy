import React, { ReactNode, useEffect, isValidElement, useRef, useState } from 'react';
import { createPortal } from 'react-dom';
import Mermaid from '@theme/Mermaid';
import BrowserOnly from '@docusaurus/BrowserOnly';
import clsx from 'clsx';
import styles from './styles.module.css';

export interface ModalProps {
  isOpen: boolean;
  onClose: () => void;
  children: ReactNode;
}

const ModalContent: React.FC<ModalProps> = ({ isOpen, onClose, children }) => {
  const overlayRef = useRef<HTMLDivElement>(null);
  const contentRef = useRef<HTMLDivElement>(null);
  const [isRendered, setIsRendered] = useState(false);
  const [isAnimating, setIsAnimating] = useState(false);

  useEffect(() => {
    let animationFrame: number;
    let timeout: NodeJS.Timeout;

    if (isOpen) {
      setIsRendered(true);
      
      timeout = setTimeout(() => {
        animationFrame = requestAnimationFrame(() => {
          setIsAnimating(true);
          contentRef.current?.focus();
        });
      }, 10);

      document.body.style.overflow = 'hidden';
      
      const handleEscape = (e: KeyboardEvent) => {
        if (e.key === 'Escape') {
          onClose();
        }
      };
      document.addEventListener('keydown', handleEscape);
      
      return () => {
        document.body.style.overflow = 'unset';
        document.removeEventListener('keydown', handleEscape);
        cancelAnimationFrame(animationFrame);
        clearTimeout(timeout);
      };
    } else {
      setIsAnimating(false);
      timeout = setTimeout(() => {
        setIsRendered(false);
      }, 200);
      return () => clearTimeout(timeout);
    }
  }, [isOpen, onClose]);

  if (!isRendered) return null;

  const modalContent = (
    <div 
      ref={overlayRef}
      className={clsx(
        styles.modalOverlay,
        isAnimating && styles.modalVisible
      )}
      onClick={onClose}
      role="dialog"
      aria-modal="true"
      aria-labelledby="modal-title"
    >
      <div 
        ref={contentRef}
        className={clsx(
          styles.modalContent,
          isAnimating && styles.modalContentVisible
        )}
        onClick={e => e.stopPropagation()}
        tabIndex={-1}
      >
        <div 
          className={styles.modalContentWrapper}
          onClick={onClose}
          role="button"
          tabIndex={0}
          aria-label="Close modal"
          title="Click to close expanded view"
        >
          <div id="modal-title" className={styles.visuallyHidden}>Modal Content</div>
          {children}
        </div>
      </div>
    </div>
  );

  return createPortal(modalContent, document.body);
};

const Modal: React.FC<ModalProps> = React.memo((props) => {
  return (
    <BrowserOnly>
      {() => <ModalContent {...props} />}
    </BrowserOnly>
  );
});

Modal.displayName = 'PreviewCardModal';

export default Modal; 