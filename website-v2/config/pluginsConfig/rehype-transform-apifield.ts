import { visit } from 'unist-util-visit';
import type { Element, Root, Text } from 'hast';
import type { Plugin } from 'unified';

/**
 * Extracts text content from an element and its children
 */
function extractText(node: Element | Text): string {
  if (node.type === 'text') {
    return node.value;
  }

  if (node.type === 'element' && node.children) {
    return node.children
      .map((child) => extractText(child as Element | Text))
      .join('');
  }

  return '';
}

/**
 * Checks if an element has a class matching the pattern
 */
function hasClassMatching(node: Element, pattern: RegExp): boolean {
  const className = node.properties?.className;
  if (Array.isArray(className)) {
    return className.some((cls) => pattern.test(String(cls)));
  }
  if (typeof className === 'string') {
    return pattern.test(className);
  }
  return false;
}

/**
 * Finds a child element with a class matching the pattern
 */
function findChildWithClass(node: Element, pattern: RegExp): Element | null {
  if (!node.children) return null;

  for (const child of node.children) {
    if (child.type === 'element' && hasClassMatching(child, pattern)) {
      return child;
    }
  }
  return null;
}

/**
 * Finds a descendant element with a class matching the pattern (recursive)
 */
function findDescendantWithClass(node: Element, pattern: RegExp): Element | null {
  if (!node.children) return null;

  for (const child of node.children) {
    if (child.type === 'element') {
      if (hasClassMatching(child, pattern)) {
        return child;
      }
      const found = findDescendantWithClass(child, pattern);
      if (found) return found;
    }
  }
  return null;
}

/**
 * Extracts the field name from the fieldName element, handling dot notation
 */
function extractFieldName(fieldNameElement: Element): string {
  // Check for dot notation structure
  const parentSpan = findChildWithClass(fieldNameElement, /fieldNameParent/);
  const propertySpan = findChildWithClass(fieldNameElement, /fieldNameProperty/);

  if (parentSpan && propertySpan) {
    // Dot notation: parent.property
    const parent = extractText(parentSpan);
    const property = extractText(propertySpan);
    return `${parent}.${property}`;
  }

  // Simple name: just extract all text
  return extractText(fieldNameElement);
}

/**
 * Rehype plugin to transform APIField components for LLM-friendly markdown
 */
const rehypeTransformApiField: Plugin<[], Root, Root> = function() {
  return function transformer(tree: Root): Root {
    visit(tree, 'element', (node: Element, index, parent) => {
      // Identify APIField components by class pattern and ID pattern
      if (!hasClassMatching(node, /^apiField_/)) {
        return;
      }

      if (!node.properties?.id || !/^field-/.test(String(node.properties.id))) {
        return;
      }

      // Extract field metadata
      const fieldHeader = findDescendantWithClass(node, /^fieldHeader_/);
      if (!fieldHeader) return;

      const fieldNameElement = findDescendantWithClass(fieldHeader, /^fieldName_/);
      if (!fieldNameElement) return;

      const fieldTypeElement = findDescendantWithClass(fieldHeader, /^fieldType_/);
      const fieldDefaultElement = findDescendantWithClass(node, /^fieldDefault_/);
      const fieldDescriptionElement = findDescendantWithClass(node, /^fieldDescription_/);

      // Extract field name
      const fieldName = extractFieldName(fieldNameElement);

      // Extract type (may contain links)
      let fieldType = 'unknown';
      if (fieldTypeElement) {
        fieldType = extractText(fieldTypeElement);
      }

      // Check if required
      let isRequired = false;
      if (fieldHeader.children) {
        for (const child of fieldHeader.children) {
          if (child.type === 'element' && hasClassMatching(child, /^fieldBadge_/)) {
            const badgeText = extractText(child).toLowerCase();
            if (badgeText === 'required') {
              isRequired = true;
              break;
            }
          }
        }
      }

      // Check if deprecated
      let isDeprecated = false;
      if (hasClassMatching(node, /deprecatedField_/)) {
        isDeprecated = true;
      }

      // Extract default value
      let defaultValue: string | null = null;
      if (fieldDefaultElement) {
        const codeElement = findDescendantWithClass(fieldDefaultElement, /.*/);
        if (codeElement && codeElement.tagName === 'code') {
          defaultValue = extractText(codeElement);
        } else {
          // Fallback: extract all text after "Default:"
          const text = extractText(fieldDefaultElement);
          const match = text.match(/Default:\s*(.+)/);
          if (match) {
            defaultValue = match[1].trim();
          }
        }
      }

      // Build the new structure
      const children: Array<Element | Text> = [];

      // Create bold paragraph: **`fieldName`** (`type`, required/optional)
      const requiredText = isRequired ? 'required' : 'optional';
      const deprecatedText = isDeprecated ? ', deprecated' : '';

      children.push({
        type: 'element',
        tagName: 'p',
        properties: {},
        children: [
          {
            type: 'element',
            tagName: 'strong',
            properties: {},
            children: [
              {
                type: 'element',
                tagName: 'code',
                properties: {},
                children: [{ type: 'text', value: fieldName }]
              }
            ]
          },
          { type: 'text', value: ' (' },
          {
            type: 'element',
            tagName: 'code',
            properties: {},
            children: [{ type: 'text', value: fieldType }]
          },
          { type: 'text', value: `, ${requiredText}${deprecatedText})` }
        ]
      });

      // Add default value if present
      if (defaultValue) {
        children.push({
          type: 'element',
          tagName: 'p',
          properties: {},
          children: [
            {
              type: 'element',
              tagName: 'strong',
              properties: {},
              children: [{ type: 'text', value: 'Default:' }]
            },
            { type: 'text', value: ' ' },
            {
              type: 'element',
              tagName: 'code',
              properties: {},
              children: [{ type: 'text', value: defaultValue }]
            }
          ]
        });
      }

      // Add description if present
      if (fieldDescriptionElement && fieldDescriptionElement.children) {
        children.push(...(fieldDescriptionElement.children as Array<Element | Text>));
      }

      // Add horizontal rule separator
      children.push({
        type: 'element',
        tagName: 'hr',
        properties: {},
        children: []
      });

      // Create a simple div wrapper to replace the APIField
      const newNode: Element = {
        type: 'element',
        tagName: 'div',
        properties: {},
        children
      };

      // Replace the APIField with the new structure
      if (parent && typeof index === 'number') {
        parent.children[index] = newNode;

        // Remove the <br/> separator if it's the next sibling
        if (parent.children[index + 1]?.type === 'element' &&
            (parent.children[index + 1] as Element).tagName === 'br') {
          parent.children.splice(index + 1, 1);
        }
      }
    });

    return tree;
  };
};

export default rehypeTransformApiField;
