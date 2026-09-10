import React from "react";

interface IconProps {
  color?: string;
  size?: number;
}

export const VideoIcon: React.FC<IconProps> = ({ color = "#044EF4", size = 24 }) => (
  <svg width={size} height={size} viewBox="0 0 41 36">
    <g clipPath="url(#clip0_419_28)">
      <path
        d="M38.2708 6.66668C37.8403 6.66668 37.4028 6.79168 37.0069 7.06251L29.3889 11.8125V7.7639C29.3889 5.93057 27.7778 4.44446 25.7917 4.44446H4.09722C2.11111 4.44446 0.5 5.93057 0.5 7.7639V27.7917C0.5 29.625 2.11111 31.1111 4.09722 31.1111H25.7917C27.7778 31.1111 29.3889 29.625 29.3889 27.7917V23.7431L37.0069 28.4861C37.4028 28.7639 37.8472 28.882 38.2708 28.882C39.4236 28.882 40.5 27.9792 40.5 26.6945V8.85418C40.5 7.56946 39.4236 6.66668 38.2708 6.66668Z"
        fill={color}
      />
    </g>
    <defs>
      <clipPath id="clip0_419_28">
        <rect width="40" height="35.5556" fill="white" transform="translate(0.5)" />
      </clipPath>
    </defs>
  </svg>
);
