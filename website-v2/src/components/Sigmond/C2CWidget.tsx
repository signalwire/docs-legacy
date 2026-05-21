import React from "react";
import BrowserOnly from "@docusaurus/BrowserOnly";
import C2CWidgetInternal from "./C2CWidgetInternal";
import useIsBrowser from "@docusaurus/useIsBrowser";
import { useState } from "react";

export default function C2CWidget({
  destination,
  supportsVideo,
  supportsAudio,
  token,
  children,
}: {
  destination: string;
  supportsVideo: boolean;
  supportsAudio: boolean;
  token: string;
  children: React.ReactNode;
}) {
  const isBrowser = useIsBrowser();
  const [randomId, setRandomId] = useState(Math.random().toString(36).substring(2, 15));
  if (!isBrowser) {
    return null;
  }
  return (
    <BrowserOnly>
      {() => (
        <>
          <div
            id={`callButton-${randomId}`}
            className="demo-button-disabled"
            style={{ flex: 1, transition: "opacity 0.4s ease-in-out" }}
          >
            {children}
          </div>
          <C2CWidgetInternal
            buttonId={`callButton-${randomId}`}
            destination={destination}
            supportsVideo={supportsVideo}
            supportsAudio={supportsAudio}
            token={token}
          />
        </>
      )}
    </BrowserOnly>
  );
}
