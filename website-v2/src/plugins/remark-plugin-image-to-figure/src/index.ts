import { visit } from "unist-util-visit";
import { position } from "unist-util-position";

function createFigureNode({ srcText, titleText, altText }: { srcText: string; titleText?: string; altText: string }) {
  return {
    type: "mdxJsxFlowElement",
    name: "figure",
    attributes: [],
    children: [
      {
        type: "mdxJsxFlowElement",
        name: "img",
        attributes: [
          {
            type: "mdxJsxAttribute",
            name: "src",
            value: srcText.startsWith("http")
              ? srcText
              : {
                  type: "mdxJsxAttributeValueExpression",
                  value: `require('${srcText}').default`,
                  data: {
                    estree: {
                      type: "Program",
                      body: [
                        {
                          type: "ExpressionStatement",
                          expression: {
                            type: "MemberExpression",
                            object: {
                              type: "CallExpression",
                              callee: {
                                type: "Identifier",
                                name: "require",
                              },
                              arguments: [
                                {
                                  type: "Literal",
                                  value: srcText,
                                  raw: `'${srcText}'`,
                                },
                              ],
                              optional: false,
                            },
                            property: {
                              type: "Identifier",
                              name: "default",
                            },
                            computed: false,
                            optional: false,
                          },
                        },
                      ],
                      sourceType: "module",
                      comments: [],
                    },
                  },
                },
          },
          {
            type: "mdxJsxAttribute",
            name: "alt",
            value: altText,
          },
        ],
        children: [],
        data: {
          _mdxExplicitJsx: true,
        },
      },
      ...(titleText
        ? [
            {
              type: "mdxJsxFlowElement",
              name: "figcaption",
              attributes: [],
              children: [
                {
                  type: "text",
                  value: titleText,
                },
              ],
              data: {
                _mdxExplicitJsx: true,
              },
            },
          ]
        : []),
    ],
    data: {
      _mdxExplicitJsx: true,
    },
  };
}

function isSvg(url: string): boolean {
  return typeof url === "string" && url.toLowerCase().endsWith(".svg");
}

export default function imageToFigure() {
  /** @type {import('unified').Transformer} */
  return (tree: any, vfile: any) => {
    visit(tree, ["image"], (node, index, parent) => {
      const srcText = node.url;
      const altText = node.alt;
      const titleText = node.title;

      let positionOfNode = position(node);

      if (/* titleText && */ srcText) {
        let newNode;
        if (isSvg(srcText)) {
          newNode = createFigureNode({
            srcText: `!file-loader!${srcText}`,
            titleText,
            altText: altText ?? "",
          });
        } else {
          newNode = createFigureNode({
            srcText,
            titleText,
            altText: altText ?? "",
          });
        }

        // vfile.info(`A markdown image changed to figure (${srcText})`, {
        //   place: positionOfNode,
        // });
        Object.assign(node, newNode);
      }
    });
  };
}
