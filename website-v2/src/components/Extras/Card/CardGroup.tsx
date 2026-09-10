import React, { ReactNode } from "react";
import styles from "./CardGroup.module.css";

export function CardGroup({
  children,
  cols = 2,
  className,
}: {
  children: ReactNode;
  cols?: 1 | 2 | 3 | 4;
  className?: string;
}) {
  return (
    <div className={`${styles.cardGroup} ${styles[`cols${cols}`]} ${className || ""}`}>
      {children}
    </div>
  );
}
