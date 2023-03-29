import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// import local files
import 'banner_img.dart';

/*
 * This class is used to display the banner carousel
 * on the home page
*/
class BannerCarousel extends StatelessWidget {
  const BannerCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.95,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: const <Widget>[
        BannerImg(imagePath: 'assets/images/banner-img-1.jpg'),
        BannerImg(imagePath: 'assets/images/banner-img-2.jpg'),
        BannerImg(imagePath: 'assets/images/banner-img-3.jpg'),
        BannerImg(imagePath: 'assets/images/banner-img-4.jpg'),
        BannerImg(imagePath: 'assets/images/banner-img-5.jpg'),
      ],
    );
  }
}

/*
CarouselSlider.builder(
  itemCount: 15,
  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
    Container(
      child: Text(itemIndex.toString()),
    ),
)*/