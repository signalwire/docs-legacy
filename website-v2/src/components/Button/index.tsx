import React from "react";
import Link from "@docusaurus/Link";
import styles from "./styles.module.scss";
import clsx from "clsx";

interface ButtonProps {
  children: React.ReactNode;
  href?: string;
  intent?: "primary" | "secondary" | "default";
  rightIcon?: string;
  className?: string;
}

export default function Button({
  children,
  href,
  intent = "default",
  rightIcon,
  className,
}: ButtonProps) {
  const content = (
    <>
      <span>{children}</span>
      {rightIcon === "arrow-right" && <span className={styles.icon}>→</span>}
    </>
  );

  if (href) {
    return (
      <Link to={href} className={clsx(styles.button, styles[intent], className)}>
        {content}
      </Link>
    );
  }

  return (
    <button className={clsx(styles.button, styles[intent], className)}>
      {content}
    </button>
  );
}
