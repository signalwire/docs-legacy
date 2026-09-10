import React, { ReactNode } from "react";
import Tabs from "@theme/Tabs";
import TabItem from "@theme/TabItem";

export default function CodeGroup({ children }: { children: ReactNode }) {
  if (children == null) {
    console.warn("CodeGroup has no children, expected at least one CodeBlock child.");
    return null;
  } else if (!Array.isArray(children)) {
    children = [children];
  } else if (children.length === 0) {
    return null;
  }

  const childArr = React.Children.toArray(children) as Array<
    Exclude<React.ReactElement<any>, boolean | null | undefined>
  >;

  return (
    <Tabs>
      {childArr.map((child, tabIndex: number) => (
        <TabItem
          key={child?.props?.filename || `tab-${tabIndex}`}
          value={child?.props?.filename || `tab-${tabIndex}`}
          // TODO: the metastring can be `title="something"` and that has special significance. Don't use that.
          label={child?.props?.children?.props?.metastring || "Filename"}
        >
          <div style={{ fontVariantLigatures: "none" }}>{child?.props?.children}</div>
        </TabItem>
      ))}
    </Tabs>
  );
}
