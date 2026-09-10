import React, { useState } from "react";
import { MdImage } from "react-icons/md";
import clsx from "clsx";
import styles from "./Card.module.css";

interface CardImageProps {
  src: string;
  alt?: string;
  className?: string;
}

export function CardImage({ src, alt, className }: CardImageProps) {
  const [imageLoaded, setImageLoaded] = useState(false);

  return (
    <div className={styles.imageWrapper}>
      {!imageLoaded && (
        <div className={styles.imageLoader}>
          <MdImage size={24} />
        </div>
      )}
      <img
        src={src}
        alt={alt || "Card image"}
        className={clsx(styles.cardImage, !imageLoaded && styles.hidden, className)}
        onLoad={() => setImageLoaded(true)}
      />
    </div>
  );
}
