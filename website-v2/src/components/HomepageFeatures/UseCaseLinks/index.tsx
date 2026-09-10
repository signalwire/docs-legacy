import Link from "@docusaurus/Link";
import React from "react";

import style from "./UseCaseLinks.module.scss";

export interface UseCaseLink {
  title: string;
  link: string;
}

export default function UseCaseLinks({ links }: { links: UseCaseLink[] }) {
  return (
    <div className={style.linkContainer}>
      {links &&
        links.map((l) => (
          <Link key={l.link} href={l.link}>
            {l.title}
          </Link>
        ))}
    </div>
  );
}
