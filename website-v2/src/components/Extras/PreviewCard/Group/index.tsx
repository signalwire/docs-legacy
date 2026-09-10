import React, { ReactNode } from 'react';
import clsx from 'clsx';
import styles from './styles.module.css';

export interface PreviewCardGroupProps {
  children: ReactNode;
  columns?: 1 | 2 | 3 | 4;
  className?: string;
}

const PreviewCardGroup: React.FC<PreviewCardGroupProps> = ({
  children,
  columns = 2,
  className,
}) => {
  return (
    <div
      className={clsx(
        'previewCardGroup',
        styles.previewCardGroup,
        styles[`cols${columns}`],
        className

      )}
    >
      {children}
    </div>
  );
};

export default PreviewCardGroup; 