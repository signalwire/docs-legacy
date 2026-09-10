import { ReactNode } from "react";

interface IndentProps {
  children?: ReactNode;
}

export default function Indent({ children }: IndentProps) {
  return (
    <div
      style={{
        borderLeft: "2px solid var(--ifm-color-emphasis-300)",
        paddingLeft: "1.5rem",
      }}
    >
      {children}
    </div>
  );
}
