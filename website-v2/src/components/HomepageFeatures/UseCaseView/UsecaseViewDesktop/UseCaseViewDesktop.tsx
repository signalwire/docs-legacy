import clsx from "clsx";
import React, { useEffect, useState } from "react";

import type { UseCases } from "../UseCaseView";
import style from "./UseCaseViewDesktop.module.scss";

export default function UseCaseViewDesktop({ data }: { data: UseCases }) {
  const [selUseCaseIdx, setSelUseCaseIdx] = useState(0);
  const [selParadigmIdx, setSelParadigmIdx] = useState(0);

  useEffect(() => {
    setSelParadigmIdx(0);
  }, [selUseCaseIdx]);

  return (
    <div className={style.container}>
      <div
        style={{
          width: 190,
          display: "flex",
          gap: 3,
          flexDirection: "column",
          height: "calc(100% - 18px)",
          overflow: "hidden",
          overflowY: "auto",
        }}
      >
        {Object.keys(data).map((useCase, idx) => (
          <button
            key={idx}
            className={clsx(style.ucbutton, idx === selUseCaseIdx ? style.selected : "")}
            onClick={(e) => setSelUseCaseIdx(idx)}
            style={{ flex: 1, maxHeight: 65 }}
          >
            {useCase}
          </button>
        ))}
      </div>
      <div style={{ width: "calc(100% - 210px)" }}>
        <div
          style={{
            overflow: "hidden",
            display: "flex",
            gap: 6,
            overflowX: "auto",
            overflowY: "hidden",
            marginBottom: 7,
          }}
        >
          {Object.keys(Object.values(data)[selUseCaseIdx]).map((paradigm, idx) => (
            <button
              key={idx}
              className={clsx(
                "button",
                style.pbutton,
                idx === selParadigmIdx && style.selected,
              )}
              onClick={() => setSelParadigmIdx(idx)}
            >
              {Object.keys(Object.values(data)[selUseCaseIdx])[idx]}
            </button>
          ))}
        </div>
        <div style={{ width: "100%", marginTop: 3 }}>
          {Object.values(Object.values(data)[selUseCaseIdx])[selParadigmIdx]}
        </div>
      </div>
    </div>
  );
}
