import React from "react";
import { ReactNode } from "react";
import styles from "./accordion.module.scss";

function AccordionGroup({ children }: { children: ReactNode }) {
  return (
    <div className={styles.accordionGroup} role="list">
      {children}
    </div>
  );
}

export default AccordionGroup;
