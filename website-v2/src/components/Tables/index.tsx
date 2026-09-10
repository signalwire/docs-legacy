import React, { ReactNode, useMemo } from 'react';
import clsx from 'clsx';
import styles from './styles.module.css';

/**
 * Table usage note:
 * - All children must be DOM elements (not React components).
 * - If using MDX partials, call them as functions (e.g. {Partial()}) so their output is traversable.
 * - Do NOT use <Partial /> as a child; this will not work for row extraction.
 */
export interface TablesProps {
  /**
   * The table content elements (can be multiple tables, MDX content, or imported partials)
   */
  children: ReactNode;
  /**
   * Optional class name to apply to table
   */
  className?: string;
  /**
   * Optional caption for the table
   */
  caption?: string;
}

function extractTables(node: ReactNode): React.ReactElement[] {
  const tables: React.ReactElement[] = [];
  React.Children.forEach(node, child => {
    if (React.isValidElement(child)) {
      if (child.type === 'table') {
        tables.push(child);
      } else if (child.props?.children) {
        tables.push(...extractTables(child.props.children));
      }
    }
  });
  return tables;
}

function getThead(table: React.ReactElement): React.ReactElement | null {
  return React.Children.toArray(table.props.children)
    .find(child => React.isValidElement(child) && child.type === 'thead') as React.ReactElement | null;
}

function getTbodyRows(table: React.ReactElement): React.ReactElement[] {
  return React.Children.toArray(table.props.children)
    .flatMap(child => {
      if (React.isValidElement(child)) {
        if (child.type === 'tbody') {
          return React.Children.toArray(child.props.children)
            .filter(row => React.isValidElement(row) && row.type === 'tr') as React.ReactElement[];
        } else if (child.type === 'tr') {
          return [child];
        }
      }
      return [];
    });
}

function headerCells(thead: React.ReactElement): string[] {
  const rows = React.Children.toArray(thead.props.children);
  if (!rows.length) return [];
  const firstRow = rows[0] as React.ReactElement;
  return React.Children.map(firstRow.props.children, (cell: React.ReactNode) => {
    if (React.isValidElement(cell)) {
      // If header is a React element, try to extract text, else fallback to stringified children
      if (typeof cell.props.children === 'string') return cell.props.children;
      if (Array.isArray(cell.props.children)) {
        return cell.props.children.map((c: any) => (typeof c === 'string' ? c : '')).join('');
      }
      return String(cell.props.children ?? '');
    }
    return '';
  }) || [];
}

export const Tables: React.FC<TablesProps> = ({
  children,
  className,
  caption
}: TablesProps) => {
  const { tables, theads, allRows, headerError } = useMemo(() => {
    const tables = extractTables(children);
    const theads = tables.map(getThead);
    let headerError: string | null = null;
    if (theads.some(thead => !thead)) {
      headerError = 'All tables must have a <thead>';
    } else {
      const firstHeader = headerCells(theads[0]!);
      theads.forEach((thead, idx) => {
        const cells = headerCells(thead!);
        if (cells.length !== firstHeader.length || !cells.every((cell, i) => cell === firstHeader[i])) {
          headerError = `Table header mismatch at table index ${idx}`;
        }
      });
    }
    const allRows = tables.flatMap(getTbodyRows);
    return { tables, theads, allRows, headerError };
  }, [children]);

  if (!tables.length) return null;
  if (headerError) {
    if (process.env.NODE_ENV === 'development') throw new Error(headerError);
    return <div className={styles.tableError}>{headerError}</div>;
  }

  return (
    <div className={styles.tableWrapper}>
      <table className={clsx(className)}>
        {caption && <caption>{caption}</caption>}
        {theads[0]}
        <tbody>
          {allRows}
        </tbody>
      </table>
    </div>
  );
};

export default Tables;
