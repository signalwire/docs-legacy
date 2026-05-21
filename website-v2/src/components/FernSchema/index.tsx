interface FernSchemaProps {
  type?: string;
  api?: string;
  title?: string;
}

/**
 * Fern-compatible Schema component.
 * In Fern, this pulled schema definitions from API specs and rendered them inline.
 * In Docusaurus, the OpenAPI plugin handles full API reference rendering.
 * This renders a placeholder pointing to the relevant API reference.
 */
export default function FernSchema({ type, api, title }: FernSchemaProps) {
  const label = title || `${type} schema`;
  return (
    <div className="admonition admonition-info alert alert--info">
      <div className="admonition-content">
        <p>
          See the <strong>{label}</strong> in the{" "}
          <a href="/apis">REST API reference</a>.
        </p>
      </div>
    </div>
  );
}
