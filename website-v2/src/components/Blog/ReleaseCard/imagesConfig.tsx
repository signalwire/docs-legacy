export interface ReleaseCardStyle {
  major: string;
  minor: string;
  patch: string;
  font: {
    fillStyle: string;
    style: () => string;
    position: (width: number, height: number) => { x: number; y: number };
  };
}

const RELEASE_CARD_FONT_SIZE = "30px";

export function mapLibraryToStyle(
  library: string,
  colorMode: "light" | "dark",
): ReleaseCardStyle {
  if (library.toLowerCase().includes("signalwire/realtime")) {
    return releaseCardImages.style1[colorMode];
  }
  if (library.toLowerCase().includes("signalwire/js")) {
    return releaseCardImages.style2[colorMode];
  }
  return releaseCardImages.style3[colorMode];
}

export interface ReleaseCardImages {
  [key: string]: {
    light: ReleaseCardStyle;
    dark: ReleaseCardStyle;
  };
}
export const releaseCardImages: ReleaseCardImages = {
  style1: {
    light: {
      major: require("./images/style1/light/major.png").default,
      minor: require("./images/style1/light/minor.png").default,
      patch: require("./images/style1/light/patch.png").default,
      font: {
        fillStyle: "#f72a72",
        style: () =>
          `bold ${RELEASE_CARD_FONT_SIZE} ${getComputedStyle(document.documentElement).getPropertyValue("--ifm-font-family-base")}`,
        position: (width: number, height: number) => ({
          x: width / 2,
          y: height * 0.5,
        }),
      },
    },
    dark: {
      major: require("./images/style1/dark/major.png").default,
      minor: require("./images/style1/dark/minor.png").default,
      patch: require("./images/style1/dark/patch.png").default,
      font: {
        fillStyle: "#f72a72",
        style: () =>
          `bold ${RELEASE_CARD_FONT_SIZE} ${getComputedStyle(document.documentElement).getPropertyValue("--ifm-font-family-base")}`,
        position: (width: number, height: number) => ({
          x: width / 2,
          y: height * 0.5,
        }),
      },
    },
  },
  style2: {
    light: {
      major: require("./images/style2/light/major.png").default,
      minor: require("./images/style2/light/minor.png").default,
      patch: require("./images/style2/light/patch.png").default,
      font: {
        fillStyle: "#f72a72",
        style: () =>
          `bold ${RELEASE_CARD_FONT_SIZE} ${getComputedStyle(document.documentElement).getPropertyValue("--ifm-font-family-base")}`,
        position: (width: number, height: number) => ({
          x: width / 2 - 140,
          y: height * 0.39,
        }),
      },
    },
    dark: {
      major: require("./images/style2/dark/major.png").default,
      minor: require("./images/style2/dark/minor.png").default,
      patch: require("./images/style2/dark/patch.png").default,
      font: {
        fillStyle: "#f72a72",
        style: () =>
          `bold ${RELEASE_CARD_FONT_SIZE} ${getComputedStyle(document.documentElement).getPropertyValue("--ifm-font-family-base")}`,
        position: (width: number, height: number) => ({
          x: width / 2 - 140,
          y: height * 0.39,
        }),
      },
    },
  },
  style3: {
    light: {
      major: require("./images/style3/light/major.png").default,
      minor: require("./images/style3/light/minor.png").default,
      patch: require("./images/style3/light/patch.png").default,
      font: {
        fillStyle: "#f72a72",
        style: () =>
          `bold ${RELEASE_CARD_FONT_SIZE} ${getComputedStyle(document.documentElement).getPropertyValue("--ifm-font-family-base")}`,
        position: (width: number, height: number) => ({
          x: width / 2,
          y: height * 0.5,
        }),
      },
    },
    dark: {
      major: require("./images/style3/dark/major.png").default,
      minor: require("./images/style3/dark/minor.png").default,
      patch: require("./images/style3/dark/patch.png").default,
      font: {
        fillStyle: "#f72a72",
        style: () =>
          `bold ${RELEASE_CARD_FONT_SIZE} ${getComputedStyle(document.documentElement).getPropertyValue("--ifm-font-family-base")}`,
        position: (width: number, height: number) => ({
          x: width / 2,
          y: height * 0.5,
        }),
      },
    },
  },
};
