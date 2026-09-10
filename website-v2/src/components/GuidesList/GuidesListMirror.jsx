import { useEffect, useState } from "react";
import GuidesList from "./GuidesList";
import { useDocsVersion } from "@docusaurus/plugin-content-docs/client";

function findItemByHref(url, object) {
  const searchItems = (items) => {
    // recursive
    for (const item of items) {
      if (item.href === url) return item;
      if (item.items && Array.isArray(item.items)) {
        const nestedResult = searchItems(item.items);
        if (nestedResult) return nestedResult;
      }
    }
    return null;
  };

  const searchSidebar = (sidebars) => {
    for (const sidebar of sidebars) {
      const result = searchItems(sidebar.items || []);
      if (result) return result;
    }
    return null;
  };

  for (const key in object) {
    if (Array.isArray(object[key])) {
      const result = searchSidebar(object[key]);
      if (result) return result;
    }
  }

  return null;
}

export default function GuidesListMirror({ href }) {
  const [items, setItems] = useState(null);
  const docsversion = useDocsVersion();

  useEffect(() => {
    if (!docsversion) return;
    const sidebar = findItemByHref(href, docsversion.docsSidebars);
    if (sidebar) {
      setItems(sidebar.items);
    }
  }, [docsversion, href]);

  return <>{items && <GuidesList items={items} />}</>;
}
