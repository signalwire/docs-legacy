import React, { ReactNode, useEffect, useState } from "react";
import { useWindowSize } from "../../../utils/hooks/useWindowSize";
import UseCaseViewDesktop from "./UsecaseViewDesktop/UseCaseViewDesktop";
import CodeCarouselMobile from "./CodeCarouselMobile/CodeCarouselMobile";
import Tabs from "@theme/Tabs";
import TabItem from "@theme/TabItem";
import type { WindowSize } from "../../../utils/hooks/useWindowSize";

export interface UseCase {
  [key: string]: ReactNode;
}

export interface UseCases {
  [key: string]: UseCase;
}

function whatView(
  size: WindowSize,
  desktopMode: boolean,
  mobileMode: boolean,
): WindowSize {
  if (desktopMode === mobileMode) {
    // both enabled or both undefined, in both cases we'll be responsive
    return size;
  } else {
    return desktopMode ? "desktop" : "mobile";
  }
}

export default function UseCaseView({
  data,
  desktopMode,
  mobileMode,
}: {
  data: UseCases;
  desktopMode: boolean;
  mobileMode: boolean;
}) {
  const size = useWindowSize();

  if (whatView(size, desktopMode, mobileMode) === "desktop") {
    return <UseCaseViewDesktop data={data} />;
  } else {
    return (
      <CodeCarouselMobile>
        {/* Flatten the UseCases nested object structure into Tabs that React Slick understands */}
        {Object.keys(data).map((useCaseKey) => (
          <Tabs key={useCaseKey}>
            {Object.keys(data[useCaseKey]).map((useCaseItemKey) => (
              <TabItem value={useCaseItemKey} label={useCaseItemKey} key={useCaseItemKey}>
                <h1>{useCaseItemKey}</h1>
                <div>{data[useCaseKey][useCaseItemKey]}</div>
              </TabItem>
            ))}
          </Tabs>
        ))}
      </CodeCarouselMobile>
    );
  }
}
