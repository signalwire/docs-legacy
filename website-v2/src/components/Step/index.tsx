import { ReactNode } from "react";

interface StepProps {
  title?: string;
  children?: ReactNode;
}

export default function Step({ title, children }: StepProps) {
  return (
    <>
      {title && <h3>{title}</h3>}
      {children}
    </>
  );
}
