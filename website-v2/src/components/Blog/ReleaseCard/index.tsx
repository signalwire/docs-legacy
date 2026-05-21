import React from "react";
import { useColorMode } from "@docusaurus/theme-common";
import { mapLibraryToStyle } from "./imagesConfig";
import { ReleaseImage } from "./ReleaseImage";

interface ReleaseCardProps {
  library: string;
  version: string;
  releaseType: "major" | "minor" | "patch";
  forceMode?: "none" | "light" | "dark";
}

export default function ReleaseCard({
  library,
  version,
  releaseType,
  forceMode = "dark",
}: ReleaseCardProps) {
  const { colorMode } = useColorMode();

  const style = mapLibraryToStyle(library, forceMode === "none" ? colorMode : forceMode);

  return (
    <div style={{ aspectRatio: "2" }}>
      <ReleaseImage
        library={library}
        version={version}
        releaseType={releaseType}
        style={style}
      />
    </div>
  );
}



