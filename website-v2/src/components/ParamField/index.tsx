import { ReactNode } from "react";
import APIField from "../APIField";

interface ParamFieldProps {
  path: string;
  type?: string;
  required?: boolean;
  default?: string;
  children?: ReactNode;
}

export default function ParamField({
  path,
  type = "",
  required,
  default: defaultValue,
  children,
}: ParamFieldProps) {
  return (
    <APIField
      name={path}
      type={type}
      required={required}
      default={defaultValue}
    >
      {children}
    </APIField>
  );
}
