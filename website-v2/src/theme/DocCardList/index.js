import React from "react";
import DocCardList from "@theme-original/DocCardList";
import { GuidesList } from "../../components/GuidesList/index";

export default function DocCardListWrapper(props) {
  return (
    <>
      <GuidesList {...props} />
      {/* <DocCardList {...props} /> */}
    </>
  );
}
