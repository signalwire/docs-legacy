import { clsx } from "clsx";
import React, { ReactNode, useState } from "react";

import AccordionCover from "./AccordionCover";

import styles from "./accordion.module.scss";

function Accordion({
  title,
  description,
  defaultOpen = false,
  icon,
  onChange,
  children,
}: {
  /** The main text of the Accordion shown in bold */
  title: string;

  /** Text under the title */
  description?: string;

  /** Whether the Accordion is open initially */
  defaultOpen?: boolean;

  /** Icon to display to the left */
  icon?: ReactNode;

  /** Callback when the Accordion is clicked with the new open state */
  onChange?: (open: boolean) => void;

  /** The Accordion contents */
  children: ReactNode;
}) {
  const [open, setOpen] = useState<boolean>(Boolean(defaultOpen));

  const onClickOpen = (open: boolean) => {
    setOpen(open);
    if (onChange) {
      onChange(open);
    }
  };

  return (
    <div key={title} role="listitem" className={styles.parent}>
      <AccordionCover
        title={title}
        description={description}
        open={open}
        setOpen={onClickOpen}
        icon={icon}
        coverClass={styles.coverClass}
      />
      <div className={clsx(styles.content, !open && styles.hidden)}>{children}</div>
    </div>
  );
}

export default Accordion;
