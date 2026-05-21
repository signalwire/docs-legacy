import React, { ComponentPropsWithoutRef, ElementType, ReactNode, Ref } from "react";
import Link from "@docusaurus/Link";
import styles from "./Card.module.css";
import clsx from "clsx";
import { CardImage } from "./CardImage";

export interface CardPropsBase<T> {
  /**
   * Large title above children.
   */
  title?: string;
  /**
   * Description text displayed below the title.
   */
  description?: string;
  /**
   * Icon next to the title.
   */
  titleIcon?: ReactNode;
  /**
   * Icon to the top-left of the title. Can be a ReactNode or a string equal to an image source.
   */
  icon?: ReactNode;
  /**
   * If provided, will render an image to the top of the card.
   */
  image?: string;
  /**
   * Type of element to be rendered.
   */
  as?: T;
  /**
   * If provided, will render as an anchor element.
   */
  href?: string;
  /**
   * Ref of the element to be rendered.
   */
  mRef?: Ref<T | undefined>;
  /**
   * If true, will render the card horizontally.
   */
  horizontal?: boolean;
}

/**
 * Props for the `Card` component
 * @typeParam T - Type of the Element rendered by the card.
 */
export type CardProps<T extends ElementType> = CardPropsBase<T> &
  Omit<ComponentPropsWithoutRef<T>, keyof CardPropsBase<T>>;

export function Card<T extends ElementType = "div">({
  title,
  description,
  icon,
  image,
  className,
  children,
  as,
  mRef,
  horizontal,
  titleIcon,
  ...props
}: CardProps<T>) {
  const Component = as || props.href != undefined ? Link : "div";
  const isString = typeof icon === "string";
  const isFaIcon = isString && /^(fa-|solid |brands )/.test(icon as string);
  const isImageSrc = isString && !isFaIcon;

  const renderIcon: ReactNode = (
    <>
      {icon ? (
        isFaIcon ? (
          <div className={styles.iconWrapper}><i className={icon as string} /></div>
        ) : isImageSrc ? (
          <img src={icon as string} alt={title} className={styles.iconImage} />
        ) : (
          <div className={styles.iconWrapper}>{icon}</div>
        )
      ) : null}
    </>
  );

  return (
    <Component
      className={clsx(
        "card",
        styles.card,
        horizontal && styles.horizontal,
        className,
        props.href != undefined && styles.card_link,
      )}
      {...props}
      ref={mRef as Ref<never>}
    >
      {image && <CardImage src={image} alt={title} />}
      <div className={styles.cardContent}>
        {renderIcon}
        {title && (
          <h2 className={`${styles.title} ${icon ? styles.titleWithIcon : ""}`}>
            {title} {titleIcon ? titleIcon : null}
          </h2>
        )}
        {description && <p className={styles.description}>{description}</p>}
        <span className={`${styles.content} ${!title ? styles.contentNoTitle : ""}`}>
          {children}
        </span>
      </div>
    </Component>
  );
}
