import React from "react";
import { BsImage } from "react-icons/bs";
import { ReleaseCardStyle } from "./imagesConfig";

interface ReleaseImageProps {
  library: string;
  version: string;
  releaseType: "major" | "minor" | "patch";
  style: ReleaseCardStyle;
}

const getImageWithText = (
  library: string,
  version: string,
  releaseType: "major" | "minor" | "patch",
  style: ReleaseCardStyle,
) => {
  const canvas = document.createElement("canvas");
  const img = new Image();
  img.src = style[releaseType];

  return new Promise<string>((resolve) => {
    img.onload = () => {
      canvas.width = img.width;
      canvas.height = img.height;
      const ctx = canvas.getContext("2d");

      if (!ctx) {
        throw new Error("Could not get canvas context");
      }

      ctx.drawImage(img, 0, 0);

      ctx.fillStyle = style.font.fillStyle;
      ctx.font = style.font.style();
      ctx.textAlign = "center";

      const text = `${library.trim()} ${version.trim()}`.trim();
      const { x, y } = style.font.position(canvas.width, canvas.height);
      ctx.fillText(text, x, y);

      resolve(canvas.toDataURL());
    };
  });
};

export function ReleaseImage({
  library,
  version,
  releaseType,
  style,
}: ReleaseImageProps) {
  const [imageUrl, setImageUrl] = React.useState<string>("");
  const [isLoading, setIsLoading] = React.useState(true);

  React.useEffect(() => {
    setIsLoading(true);
    getImageWithText(library, version, releaseType, style).then((url) => {
      setImageUrl(url);
      setIsLoading(false);
    });
  }, [library, version, releaseType, style]);

  if (isLoading) {
    return (
      <div
        style={{
          aspectRatio: "2",
          background: "var(--ifm-background-surface-color)",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          borderRadius: "8px",
        }}
      >
        <BsImage
          size={32}
          style={{
            color: "var(--ifm-color-primary-lighter)",
          }}
        />
      </div>
    );
  }

  return (
    <img
      src={imageUrl}
      alt={`${library} ${version} release`}
      style={{ borderRadius: "8px" }}
    />
  );
}
