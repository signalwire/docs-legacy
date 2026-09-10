import { ReactNode } from "react";
import Admonition from "@theme/Admonition";

interface CalloutProps {
  title?: string;
  icon?: string;
  children?: ReactNode;
}

export function Warning({ title, children }: CalloutProps) {
  return <Admonition type="warning" title={title}>{children}</Admonition>;
}

export function Info({ title, children }: CalloutProps) {
  return <Admonition type="info" title={title}>{children}</Admonition>;
}

export function Tip({ title, children }: CalloutProps) {
  return <Admonition type="tip" title={title}>{children}</Admonition>;
}

export function Note({ title, children }: CalloutProps) {
  return <Admonition type="note" title={title}>{children}</Admonition>;
}

export function Success({ title, children }: CalloutProps) {
  return <Admonition type="tip" title={title}>{children}</Admonition>;
}

export function Error({ title, children }: CalloutProps) {
  return <Admonition type="danger" title={title}>{children}</Admonition>;
}
