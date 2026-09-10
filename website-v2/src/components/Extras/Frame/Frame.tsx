import React from "react";
import styles from "./Frame.module.css";
import clsx from "clsx";
import OgImage from "../../OgImage";

// Adds className to img elements so it persists when medium-zoom clones them
function addClassToImages(children: React.ReactNode, className?: string): React.ReactNode {
  if (!className) return children;

  if (React.isValidElement(children)) {
    if (children.type === "img") {
      return React.cloneElement(children, {
        className: clsx(children.props.className, className),
      });
    }
    if (children.props?.children) {
      return React.cloneElement(children, {
        children: addClassToImages(children.props.children, className),
      });
    }
  }

  if (Array.isArray(children)) {
    return children.map((child, i) =>
      React.isValidElement(child)
        ? React.cloneElement(addClassToImages(child, className) as React.ReactElement, { key: i })
        : child
    );
  }

  return children;
}

function extractImagesFromParagraph(
  children: React.ReactNode,
  className?: string
): {
  content: React.ReactNode;
  single: boolean;
} {
  if (React.isValidElement(children) && children.type === "p") {
    const pChildren = children.props.children;
    const single = !Array.isArray(pChildren);

    if (Array.isArray(pChildren)) {
      const processedChildren = pChildren.map((child) => {
        if (React.isValidElement(child) && child.type === "figure") {
          return React.isValidElement(child) ? (
            <div className={styles.imageWrapper}>{addClassToImages(child.props?.children, className)}</div>
          ) : (
            child
          );
        }
        return child;
      });
      return { content: processedChildren, single };
    }

    if (React.isValidElement(pChildren) && pChildren.type === "figure") {
      return {
        content: <div className={styles.imageWrapper}>{addClassToImages(pChildren.props?.children, className)}</div>,
        single,
      };
    }

    return { content: pChildren, single };
  }
  return {
    content:
      React.isValidElement(children) && children.type === "figure" ? (
        <div className={styles.imageWrapper}>{addClassToImages(children.props?.children, className)}</div>
      ) : (
        addClassToImages(children, className)
      ),
    single: false,
  };
}

function extractFirstImageSrc(children: React.ReactNode): string | undefined {
  if (React.isValidElement(children)) {
    if (children.type === "img" && children.props?.src) {
      return children.props.src;
    }

    if (children.type === "figure") {
      const figureChildren = children.props?.children;
      if (React.isValidElement(figureChildren) && figureChildren.type === "img") {
        return figureChildren.props?.src;
      }
    }

    if (children.type === "p") {
      const pChildren = children.props?.children;
      if (Array.isArray(pChildren)) {
        for (const child of pChildren) {
          const src = extractFirstImageSrc(child);
          if (src) return src;
        }
      } else {
        return extractFirstImageSrc(pChildren);
      }
    }
  }
  return undefined;
}

export default function Frame({
  caption,
  children,
  ogImage = false,
  className,
}: {
  caption?: string;
  children: React.ReactNode;
  ogImage?: boolean;
  className?: string;
}) {
  const { content: processedChildren, single } = extractImagesFromParagraph(children, className);
  const ogImageSrc = ogImage ? extractFirstImageSrc(children) : undefined;

  return (
    <>
      {ogImage && ogImageSrc && <OgImage img={ogImageSrc} />}
      <div className={clsx(styles.container, "lightbox")}>
        <div className={clsx(styles.frame)}>
          <div className={clsx(styles.gridOverlay)} />
          <div className={clsx(single ? styles.content : styles.contentMultiple)}>
            {processedChildren}
          </div>

          {caption && (
            <div className={clsx(styles.caption)}>
              <p>{caption}</p>
            </div>
          )}
          <div className={clsx(styles.border)} />
        </div>
      </div>
    </>
  );
}
