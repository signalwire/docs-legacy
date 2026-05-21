import React, { ReactNode, useRef } from "react";
import Slider from "react-slick";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import { useWindowSize } from "../../../../utils/hooks/useWindowSize";
import styles from "./CodeCarouselMobile.module.css";
import "./style.css";
import clsx from "clsx";
import { FaArrowRight, FaArrowLeft } from "react-icons/fa6";

var desktopSettings = {
  dots: false,
  infinite: true,
  speed: 220,
  slidesToShow: 1,
  slidesToScroll: 1,
  //adaptiveHeight: true,
};

var mobileSettings = {
  dots: false,
  infinite: true,
  speed: 220,
  slidesToShow: 1,
  slidesToScroll: 1,
  //adaptiveHeight: true,

  //we don't want horizontal scroll action for code to conflict with swipe gesture
  swipe: false,
  arrows: false,
};

export default function CodeCarouselMobile({ children }: { children: ReactNode[] }) {
  let sliderRef = useRef<Slider>(null);
  const size = useWindowSize();

  return (
    <div className={clsx(styles.carousel, size === "mobile" && styles.carouselMobile)}>
      <Slider
        {...(size === "mobile" ? mobileSettings : desktopSettings)}
        ref={(slider) => {
          sliderRef = { current: slider };
        }}
      >
        {children.map((child, idx) => (
          <div key={idx} className={styles.container}>
            {child}
          </div>
        ))}
      </Slider>
      {size === "mobile" && (
        <div style={{ display: "flex", justifyContent: "center", marginTop: 20 }}>
          <button
            className="button button--primary"
            style={{
              marginRight: 10,
              color: "white",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
            }}
            onClick={(e) => sliderRef.current?.slickPrev()}
          >
            <FaArrowLeft />
          </button>
          <button
            className="button button--primary"
            style={{
              color: "white",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
            }}
            onClick={(e) => sliderRef.current?.slickNext()}
          >
            <FaArrowRight />
          </button>
        </div>
      )}
    </div>
  );
}
