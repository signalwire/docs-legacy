import React from "react";
import { Helmet } from "react-helmet-async";

// Why do we need this?
// - https://github.com/facebook/docusaurus/blob/cd2792775e379f9583385a8fb7b03e74c0f8853e/packages/docusaurus-mdx-loader/src/utils.ts#L46
// - docusaurus has hardcoded the image tag in frontmatter to only understand links starting with `./` as needing to be 'require`d but not `base-64`ed
// To reference `@site` or `@image` aliases, we need to use this component.

export default function OgImage({ img }: { img: string }) {
  return (
    <Helmet>
      <meta property="og:image" content={img} data-rh="true" />
    </Helmet>
  );
}
