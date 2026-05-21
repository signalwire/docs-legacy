import React from "react";

interface IconProps {
  color?: string;
  size?: number;
}

export const ChatIcon: React.FC<IconProps> = ({ color = "#044EF4", size = 24 }) => (
  <svg width={size} height={size} viewBox="0 0 40 40">
    <path
      d="M26 4V18H6.34L5.16 19.18L4 20.34V4H26ZM28 0H2C0.9 0 0 0.9 0 2V30L8 22H28C29.1 22 30 21.1 30 20V2C30 0.9 29.1 0 28 0ZM38 8H34V26H8V30C8 31.1 8.9 32 10 32H32L40 40V10C40 8.9 39.1 8 38 8Z"
      fill={color}
    />
  </svg>
);
