import style from "./steps.module.scss";

export default function Steps({ children }) {
  return <div className={style.stepped}>{children}</div>;
}
