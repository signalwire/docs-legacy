import React from "react";

interface IconProps {
  color?: string;
  size?: number;
}

export const FaxIcon: React.FC<IconProps> = ({ color = "#044EF4", size = 24 }) => (
  <svg
    width={size}
    height={size}
    viewBox="0 0 119.12 122.88"
    enableBackground="new 0 0 119.13 122.88"
  >
    <path
      fillRule="evenodd"
      clipRule="evenodd"
      d="M60.6,42.6h35.84v5.48H60.6V42.6L60.6,42.6z M5.64,23.89H9.5v82.76c0,3.92,3.21,7.12,7.12,7.12h23.12 c3.92,0,7.12-3.21,7.12-7.12V23.89h5.87V0h47.33l1.61,0.67l10.61,10.47l0.68,0.67v12.07l0.52,0c3.11,0,5.64,2.54,5.64,5.65v87.7 c0,3.1-2.54,5.65-5.64,5.65H5.64c-3.11,0-5.64-2.54-5.64-5.65l0-87.7C0,26.43,2.54,23.89,5.64,23.89L5.64,23.89z"
      fill={color}
    />
    {/* Add remaining paths with same fill color */}
  </svg>
);
