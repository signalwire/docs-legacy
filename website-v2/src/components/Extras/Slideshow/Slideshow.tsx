import React from "react";
import Slider from "react-slick";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import styles from "./Slideshow.module.css";
import { useColorMode } from "@docusaurus/theme-common";

interface SlideshowProps {
  images: string[];
  interval?: number;
}

const settings = {
  dots: true,
  infinite: true,
  speed: 500,
  slidesToShow: 1,
  slidesToScroll: 1,
  autoplay: true,
  autoplaySpeed: 3000,
};

export default function Slideshow({ images }: SlideshowProps) {
  return (
    <div className={styles.slideshow}>
      <Slider {...settings}>
        {images.map((image, index) => (
          <div key={index}>
            <img src={image} alt={`Slide ${index + 1}`} className={styles.slide} />
          </div>
        ))}
      </Slider>
    </div>
  );
}
