import React from 'react';
import { APITable } from '../APITable';

interface TableRow {
  id: string;
  name?: string;
  parameter?: string;
  url?: string;
  required?: 'required' | 'optional' | 'conditional';
  [key: string]: any;
}

interface TableData {
  columns?: string[];
  align?: 'left' | 'center' | 'right';
  rows: TableRow[];
}

interface RowFilter {
  filter: 'include' | 'exclude';
  ids: string[];
}

interface SharedTableProps {
  columns?: string[];
  data: TableData;
  rowIds?: RowFilter;
  filterRequired?: boolean;
  align?: 'left' | 'center' | 'right';
}

const SharedTable: React.FC<SharedTableProps> = ({
  columns: propColumns,
  data,
  rowIds,
  filterRequired,
  align: propAlign
}) => {
  // Use columns and alignment from data if not provided as props
  const columns = propColumns || data.columns || ['Name', 'Type', 'Default', 'Description'];
  const align = propAlign || data.align || 'left';
  
  // Filter rows based on rowIds
  let filteredRows = data.rows;

  if (rowIds) {
    if (rowIds.filter === 'include') {
      filteredRows = filteredRows.filter(row => rowIds.ids.includes(row.id));
    } else if (rowIds.filter === 'exclude') {
      filteredRows = filteredRows.filter(row => !rowIds.ids.includes(row.id));
    }
  }

  // Filter by required status if specified
  if (filterRequired !== undefined) {
    filteredRows = filteredRows.filter(row => {
      if (filterRequired === true) {
        return row.required === 'required';
      } else if (filterRequired === false) {
        return row.required === 'optional';
      }
      return true;
    });
  }

  // Generate required indicator span
  const getRequiredIndicator = (required?: string) => {
    switch (required) {
      case 'required':
        return <span className="required-arg">Required</span>;
      case 'optional':
        return <span className="optional-arg">Optional</span>;
      case 'conditional':
        return <span className="conditional-arg">Conditional</span>;
      default:
        return null;
    }
  };

  // Validate that columns match available data fields
  const validateColumnMapping = () => {
    if (filteredRows.length === 0) return;
    
    const sampleRow = filteredRows[0];
    const missingFields: string[] = [];
    
    columns.forEach((column, index) => {
      const columnKey = column.toLowerCase().replace(/\s+/g, '');
      if (index === 0) {
        // First column can use 'name', 'parameter', or exact column match
        if (!sampleRow.name && !sampleRow.parameter && !sampleRow[columnKey]) {
          missingFields.push(`${column} (looking for: name, parameter, or ${columnKey})`);
        }
      } else if (sampleRow[columnKey] === undefined) {
        missingFields.push(`${column} (looking for: ${columnKey})`);
      }
    });

    if (missingFields.length > 0) {
      throw new Error(
        `SharedTable: Column mapping mismatch detected.\n` +
        `Missing fields: ${missingFields.join(', ')}\n` +
        `Available fields: ${Object.keys(sampleRow).join(', ')}`
      );
    }
  };

  // ReactMarkdown component loaded dynamically
  const ReactMarkdownComponent: React.FC<{ children: string }> = ({ children }) => {
    const [ReactMarkdown, setReactMarkdown] = React.useState<any>(null);
    
    React.useEffect(() => {
      // Dynamic import to handle ES module
      import('react-markdown').then((module) => {
        setReactMarkdown(() => module.default);
      });
    }, []);
    
    if (!ReactMarkdown) {
      // Fallback while loading
      return <span>{children}</span>;
    }
    
    return (
      <ReactMarkdown
        components={{
          p: ({ children }) => <span>{children}</span>, // Use span instead of p to avoid block layout
          code: ({ children }) => <code>{children}</code>,
          a: ({ href, children }) => (
            <a href={href} target="_blank" rel="noopener noreferrer">
              {children}
            </a>
          ),
          // Disable lists in table cells
          ul: ({ children }) => <span>{children}</span>,
          ol: ({ children }) => <span>{children}</span>,
          li: ({ children }) => <span>- {children}</span>,
        }}
      >
        {children}
      </ReactMarkdown>
    );
  };

  // Validate columns before rendering
  validateColumnMapping();

  // Render cell content with proper formatting
  const renderCellContent = (row: TableRow, columnIndex: number) => {
    const columnKey = columns[columnIndex].toLowerCase().replace(/\s+/g, '');

    // Special handling for first column (name/parameter field)
    if (columnIndex === 0) {
      const rawContent = row.name || row.parameter || row[columnKey] || '';
      const url = row.url;
      
      // First column - wrap in code tag and add required indicator
      if (rawContent) {
        // Remove backticks if they exist and wrap in code tag
        const cleanContent = typeof rawContent === 'string' && rawContent.startsWith('`') && rawContent.endsWith('`')
          ? rawContent.slice(1, -1)
          : rawContent;
        
        const indicator = getRequiredIndicator(row.required);
        
        // Wrap in link if URL is provided
        const codeElement = url ? (
          <a href={url} target="_blank" rel="noopener noreferrer">
            <code>{cleanContent}</code>
          </a>
        ) : (
          <code>{cleanContent}</code>
        );
        
        return (
          <>
            {codeElement}
            {indicator}
          </>
        );
      }
      return '';
    }
    
    // Handle other columns - render with ReactMarkdown for rich content support
    const rawContent = row[columnKey] || '';
    
    if (typeof rawContent === 'string') {
      // For simple values like "-", don't use ReactMarkdown to avoid list interpretation
      if (rawContent === '-' || rawContent.trim() === '-') {
        return rawContent;
      }
      return <ReactMarkdownComponent>{rawContent}</ReactMarkdownComponent>;
    }
    
    return rawContent;
  };

  return (
    <APITable>
      <table style={{ textAlign: align }}>
        <thead>
          <tr>
            {columns.map((column, index) => (
              <th key={index}>{column}</th>
            ))}
          </tr>
        </thead>
        <tbody>
          {filteredRows.map((row) => (
            <tr key={row.id} data-row-slug={row.id}>
              {columns.map((_, columnIndex) => (
                <td key={columnIndex}>
                  {renderCellContent(row, columnIndex)}
                </td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </APITable>
  );
};

export default SharedTable;