import React, { ReactNode, useState, useRef, useEffect, useId } from 'react';
import { useWindowSize } from '@docusaurus/theme-common';
import clsx from 'clsx';
import styles from './styles.module.css';
// @ts-expect-error ES module import; handled correctly by bundler
import ReactMarkdown from 'react-markdown';
// @ts-expect-error ES module import; handled correctly by bundler
import remarkGfm from 'remark-gfm';
// @ts-expect-error ES module import; handled correctly by bundler
import rehypeRaw from 'rehype-raw';

interface TooltipProps {
  children: ReactNode;
  /**
   * The tooltip content. Can be a string containing Markdown/MDX **or** a React node.
   */
  tip: string | ReactNode;
}

export default function Tooltips({ 
  children, 
  tip
}: TooltipProps) {
  const windowSize = useWindowSize();
  const isMobile = windowSize === 'mobile';
  const [isVisible, setIsVisible] = useState(false);
  const tooltipId = useId();
  const containerRef = useRef<HTMLSpanElement>(null);

  if (!tip || !children) {
    throw new Error('Tooltip requires both tip content and children');
  }

  // Handle click outside and body scrolling for mobile
  useEffect(() => {
    if (!isMobile) return;
    
    const handleClickOutside = (event: MouseEvent) => {
      if (containerRef.current && !containerRef.current.contains(event.target as Node)) {
        setIsVisible(false);
      }
    };
    
    if (isVisible) {
      document.body.style.overflow = 'hidden';
      document.addEventListener('mousedown', handleClickOutside);
    } else {
      document.body.style.overflow = '';
    }
    
    return () => {
      document.body.style.overflow = '';
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, [isMobile, isVisible]);

  const handleEvents = {
    onMouseEnter: () => !isMobile && setIsVisible(true),
    onMouseLeave: () => !isMobile && setIsVisible(false),
    onFocus: () => !isMobile && setIsVisible(true),
    onBlur: () => !isMobile && setIsVisible(false),
    onClick: (e: React.MouseEvent) => {
      if (isMobile) {
        e.preventDefault();
        setIsVisible(prev => !prev);
      }
    }
  };

  return (
    <>
      {/* Darkened, blurred backdrop for mobile */}
      {isMobile && (
        <div 
          className={clsx(styles.tooltipBackdrop, isVisible && styles.visible)}
          onClick={() => setIsVisible(false)}
        />
      )}
      
      <span 
        ref={containerRef}
        className={styles.tooltipContainer}
        {...handleEvents}
        tabIndex={0}
        aria-describedby={tooltipId}
      >
        {children}
        <div 
          id={tooltipId}
          className={clsx(
            styles.tooltip,
            isMobile && styles.tooltipMobile,
            isVisible && styles.visible
          )}
          role="tooltip"
          aria-expanded={isVisible}
        >
          <div className={styles.tooltipContent}>
            {typeof tip === 'string' ? (
              <ReactMarkdown
                remarkPlugins={[remarkGfm as any]}
                rehypePlugins={[rehypeRaw as any]}
                components={{
                  p: ({ node, ...props }) => <span {...props} />, 
                }}
              >
                {tip}
              </ReactMarkdown>
            ) : (
              tip
            )}
          </div>
          
          {/* Separate arrow element outside of scrollable content */}
          <div className={styles.tooltipArrow} />
        </div>
      </span>
    </>
  );
}
