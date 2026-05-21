import style from "./subtitle.module.scss";

export default function Subtitle({ children }) {
  return (
    <>
      <span className={style.subtitle}>{children}</span>
      <br />
      <br />
    </>
  );
}
