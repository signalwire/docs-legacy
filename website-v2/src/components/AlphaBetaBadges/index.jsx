import Link from "@docusaurus/Link";

function Base({ text, color }) {
  return (
    <div
      style={{
        fontSize: 14,
        padding: "4px 10px",
        background: color,
        width: "fit-content",
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
        borderRadius: 10,
        fontWeight: "bold",
        marginBottom: 30,
        minWidth: 80,
      }}
    >
      <Link
        to={`/sdks/#${text.toLowerCase()}`}
        style={{ color: "white" }}
        className="badge-link"
      >
        {text}
      </Link>
    </div>
  );
}

export function AlphaBadge() {
  return <Base text="ALPHA" color="var(--ifm-color-danger)" />;
}

export function BetaBadge() {
  return <Base text="BETA" color="var(--ifm-color-warning)" />;
}
