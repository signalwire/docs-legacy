import { clsx } from "clsx";
import React from "react";
import type { IconType } from "react-icons/lib";
import styles from "./accordion.module.scss";
import { ExpandableItemCoverIcon } from "../Expandable/ExpandableItemCoverIcon";

function AccordionItemCover({
  title,
  description,
  open,
  setOpen,
  icon,
  coverClass,
}: {
  title: string;
  description?: string;
  open: boolean;
  setOpen: (open: boolean) => any;
  icon?: IconType;
  coverClass: string;
}) {
  return (
    <button
      onClick={() => setOpen(!open)}
      className={clsx(styles.resetButtonStyle, styles.accordionHiddenButton, coverClass)}
      aria-controls={title + "Children"}
      aria-expanded={open}
    >
      <div className={styles.expandIcon}>
        <ExpandableItemCoverIcon open={open} />
      </div>
      {icon ? <div className={styles.icon}>{icon}</div> : null}
      <div className={styles.textContainer}>
        <p className={styles.title}>{title}</p>
        {description ? <p className={styles.description}>{description}</p> : null}
      </div>
    </button>
  );
}

export default AccordionItemCover;
