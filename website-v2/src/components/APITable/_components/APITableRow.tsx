// APITableRow.tsx

import React, {
  useEffect,
  forwardRef,
  ReactElement,
  MouseEvent,
  KeyboardEvent,
} from 'react';
import { useHistory } from '@docusaurus/router';
import useBrokenLinks from '@docusaurus/useBrokenLinks';
import styles from '../styles.module.css';

interface TableRowProps extends React.ComponentPropsWithoutRef<'tr'> {
  'data-row-slug'?: string;
  children?: React.ReactNode;
}

interface APITableRowProps {
  name?: string;
  children: ReactElement<TableRowProps>;
}

const getRowName = (node: ReactElement): string | null => {
  let current: React.ReactNode = node;
  while (React.isValidElement(current)) {
    const [firstChild] = React.Children.toArray(
      current.props.children
    );
    if (firstChild) {
      current = firstChild;
    } else {
      break;
    }
  }
  return typeof current === 'string' ? current : null;
};

const APITableRow = forwardRef<HTMLTableRowElement, APITableRowProps>(
  ({ name, children }, ref) => {
    const dataRowSlug = children.props['data-row-slug'];
    const id = dataRowSlug || getRowName(children) || undefined;
    const anchor = id ? `#${id}` : '';
    const history = useHistory();
    const { collectAnchor } = useBrokenLinks();

    useEffect(() => {
      if (id) {
        collectAnchor(id);
      }
    }, [id, collectAnchor]);

    const handleClick = (e: MouseEvent) => {
      const target = e.target as HTMLElement;
      if (
        target.tagName.toLowerCase() === 'a' ||
        target.closest('a')
      ) {
        e.stopPropagation(); // Prevent row click when clicking a link
      } else if (id) {
        history.push(anchor);
      }
    };

    const handleKeyDown = (e: KeyboardEvent) => {
      if (id && e.key === 'Enter') {
        history.push(anchor);
      }
    };

    return (
      <tr
        className={styles.apiTableRow}
        id={id}
        tabIndex={id ? 0 : undefined}
        ref={
          id && history.location.hash === anchor
            ? (ref as React.RefObject<HTMLTableRowElement>)
            : undefined
        }
        onClick={handleClick}
        onKeyDown={handleKeyDown}
      >
        {children.props.children}
      </tr>
    );
  }
);

export default React.memo(APITableRow);
