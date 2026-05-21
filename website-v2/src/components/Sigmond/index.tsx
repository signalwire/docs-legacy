import React from "react";
import token from "./token";
import C2CWidget from "./C2CWidget";
import styles from "./demo.module.scss";
import clsx from "clsx";

export default function Home(): JSX.Element {
  return (
    <C2CWidget
      destination="/private/demo-1"
      supportsVideo={true}
      supportsAudio={true}
      token={token}
    >
      <div className={clsx(styles.container, styles.card)}>
        <div className={styles.imageContainer}>
          <img
            src={require("./sigmond.webp").default}
            alt="Sigmond"
            className={styles.sigmondGif}
          />
        </div>
        <div className={styles.content}>
          <h1 className={styles.title}>Hi, I'm Sigmond!</h1>
          <p>I'll answer questions about SignalWire and help you get started. </p>
          <p>
            <b>Click here to call me!</b>
          </p>
        </div>
      </div>
    </C2CWidget>
  );
}
