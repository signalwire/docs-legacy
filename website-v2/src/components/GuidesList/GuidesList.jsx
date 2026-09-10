import { useCurrentSidebarCategory } from "@docusaurus/theme-common";
import { useEffect, useState } from "react";
import { Card, CardGroup } from "@site/src/components/Extras/Card";
import { useDocById } from "@docusaurus/plugin-content-docs/client";
import { micromark } from "micromark";
import {
  SiBookstack,
  SiPython,
  SiJavascript,
  SiReact,
  SiVuedotjs,
  SiRuby,
  SiGithub,
} from "react-icons/si";
import { GiOpenBook } from "react-icons/gi";
import { HiExternalLink } from "react-icons/hi";

function stripMarkdown(markdown) {
  const hiddenDiv = document.createElement("div");
  hiddenDiv.style.display = "none";
  hiddenDiv.innerHTML = micromark(markdown);
  document.body.appendChild(hiddenDiv);
  const text = hiddenDiv.textContent || hiddenDiv.innerText || "";
  document.body.removeChild(hiddenDiv);
  const words = text.trim().split(/\s+/);
  return words.length > 20 ? words.slice(0, 20).join(" ") + "..." : text;
}

function GuideCardWrapper({ item }) {
  const doc = useDocById(item.docId ?? undefined);
  const externalLink = item.className?.includes("external-link");

  const platformIcons = {
    python: <SiPython />,
    javascript: <SiJavascript />,
    react: <SiReact />,
    vuejs: <SiVuedotjs />,
    ruby: <SiRuby />,
  };

  const platform = item?.customProps?.platform;
  const PlatformIcon = platform ? platformIcons[platform.toLowerCase()] : null;

  return (
    <Card
      title={item.label}
      titleIcon={externalLink ? <HiExternalLink /> : null}
      icon={item.type === "category" ? <SiBookstack /> : <GiOpenBook />}
      horizontal
      href={item.href}
    >
      <>
        {doc?.description ? (
          <p>{stripMarkdown(doc.description)}</p>
        ) : (
          item.customProps?.description && <p>{item.customProps.description}</p>
        )}

        <div style={{ marginTop: 10, opacity: 0.9 }}>
          {item.type === "category" && (
            <>
              {item.description && <p>{item.description}</p>}
              <div>{`${item.items.length} items`}</div>
            </>
          )}
        </div>

        <div style={{ marginTop: 8, display: "flex", gap: "12px", alignItems: "center" }}>
          {PlatformIcon && (
            <a
              href={`/guides?tags=language%3A${platform.toLowerCase()}`}
              style={{ color: "inherit", fontSize: "1.2em" }}
            >
              {PlatformIcon}
            </a>
          )}
          {item.customProps?.github && (
            <a
              href={item.customProps.github}
              target="_blank"
              rel="noopener noreferrer"
              style={{ color: "inherit", fontSize: "1.2em" }}
            >
              <SiGithub />
            </a>
          )}
        </div>
      </>
    </Card>
  );
}

export default function GuidesList({ items = null }) {
  const sidebarItems = useCurrentSidebarCategory();
  const [itemsToUse, setItemsToUse] = useState(null);

  useEffect(() => {
    if (items === null) {
      setItemsToUse(sidebarItems.items);
    } else {
      setItemsToUse(items);
    }
  }, [items, sidebarItems]);

  return (
    <CardGroup cols={2}>
      {itemsToUse &&
        itemsToUse
          ?.filter((i) => !(i?.customProps?.hideFromIndex === true || i?.draft === true))
          ?.map((item, idx) => (
            <GuideCardWrapper key={idx} item={item}></GuideCardWrapper>
          ))}
    </CardGroup>
  );
}
