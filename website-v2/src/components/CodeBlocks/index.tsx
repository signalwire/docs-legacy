import React, { ReactNode, Children, isValidElement } from "react";
import Tabs from "@theme/Tabs";
import TabItem from "@theme/TabItem";

interface CodeBlocksProps {
  children?: ReactNode;
}

interface CodeBlockProps {
  title?: string;
  children?: ReactNode;
}

/**
 * Extract a label from a code fence element.
 * MDX renders ```lang title="X" as a <pre><code className="language-lang" title="X">
 */
function getCodeFenceLabel(element: React.ReactElement): string {
  const props = element?.props as Record<string, unknown> | undefined;
  const child = props?.children;
  if (isValidElement(child)) {
    const childProps = child.props as Record<string, unknown>;
    if (typeof childProps.title === "string") return childProps.title;
    const className = childProps.className as string | undefined;
    if (className) {
      const match = className.match(/language-(\w+)/);
      if (match) return match[1];
    }
  }
  return "Code";
}

export function CodeBlocks({ children }: CodeBlocksProps) {
  let counter = 0;
  const items = Children.toArray(children)
    .filter((child) => isValidElement(child))
    .map((child) => {
      const el = child as React.ReactElement;
      const elProps = el.props as Record<string, unknown>;

      // Already a native TabItem — pass through
      if (el.type === TabItem || elProps?.value !== undefined) {
        return el;
      }

      // CodeBlock component (Fern) — convert to TabItem
      const typeName = (el.type as { name?: string })?.name;
      if (typeName === "CodeBlock" || elProps?.title !== undefined) {
        const label = (elProps.title as string) || "Code";
        const value = `${label}-${counter++}`;
        return (
          <TabItem key={value} value={value} label={label}>
            {elProps.children as ReactNode}
          </TabItem>
        );
      }

      // Raw code fence (pre element) — wrap in TabItem
      const label = getCodeFenceLabel(el);
      const value = `${label}-${counter++}`;
      return (
        <TabItem key={value} value={value} label={label}>
          {el}
        </TabItem>
      );
    });

  return <Tabs>{items}</Tabs>;
}

export function CodeBlock({ title, children }: CodeBlockProps) {
  const label = title || "Code";
  return (
    <TabItem value={label} label={label}>
      {children}
    </TabItem>
  );
}
