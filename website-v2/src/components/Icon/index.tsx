import { FaCircleInfo, FaRightLeft } from "react-icons/fa6";
import { IconType } from "react-icons";

const iconMap: Record<string, IconType> = {
  "circle-info": FaCircleInfo,
  "right-left": FaRightLeft,
};

interface IconProps {
  icon: string;
  size?: string;
  className?: string;
}

export default function Icon({ icon, size, className }: IconProps) {
  const IconComponent = iconMap[icon];
  if (!IconComponent) return null;
  const fontSize = size ? `${size}rem` : undefined;
  return <IconComponent style={{ fontSize }} className={className} aria-hidden="true" />;
}
