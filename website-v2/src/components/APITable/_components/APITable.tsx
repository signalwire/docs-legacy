// APITable.tsx

import React from 'react';
import APITableRow from './APITableRow';
import styles from '../styles.module.css';

interface Props {
  readonly children: React.ReactElement<React.ComponentProps<'table'>>;
  readonly name?: string;
}

const APITable = ({ children, name }: Props): JSX.Element => {
  if (children.type !== 'table') {
    throw new Error(
      'Incorrect usage of APITable component. Ensure your Markdown table is correctly formatted with the appropriate number of columns for each row.'
    );
  }

  const [thead, tbody] = React.Children.toArray(
    children.props.children
  ) as [
    React.ReactElement<React.ComponentProps<'thead'>>,
    React.ReactElement<React.ComponentProps<'tbody'>>
  ];

  const renderCell = (
    cell: React.ReactElement,
    CellTag: 'th' | 'td'
  ) => {
    const align = cell.props.align || 'left'; // Default to 'left' if not specified
    const style = { textAlign: align as 'left' | 'center' | 'right' };

    return (
      <CellTag style={style}>
        {cell.props.children}
      </CellTag>
    );
  };

  const renderedThead = React.cloneElement(thead, {
    children: React.cloneElement(thead.props.children as React.ReactElement, {
      children: React.Children.map(
        (thead.props.children as React.ReactElement).props.children,
        (cell) => renderCell(cell as React.ReactElement, 'th')
      ),
    }),
  });

  const highlightedRow = React.useRef<HTMLTableRowElement>(null);

  React.useEffect(() => {
    highlightedRow.current?.focus();
  }, []);

  const rows = React.Children.map(tbody.props.children, (row) => (
    <APITableRow name={name} ref={highlightedRow}>
      {React.cloneElement(row as React.ReactElement, {
        children: React.Children.map(
          (row as React.ReactElement).props.children,
          (cell) => renderCell(cell as React.ReactElement, 'td')
        ),
      })}
    </APITableRow>
  ));

  return (
    <table className={styles.apiTable}>
      {renderedThead}
      <tbody>{rows}</tbody>
    </table>
  );
};

export default React.memo(APITable);
