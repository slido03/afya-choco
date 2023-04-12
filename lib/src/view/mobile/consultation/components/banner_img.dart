import 'package:flutter/material.dart';

/*
 * This class is used to display the banner image
 * in the banner-carousel
*/
class BannerImg extends StatelessWidget {
  final String imagePath;

  const BannerImg({super.key, required this.imagePath});

  // cache the image that path is passed in the constructor
  // to avoid loading the image each time the widget is built
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: double.infinity,
      decoration:  BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        image: DecorationImage(
          // cache the image that path is passed in the constructor
          // to avoid loading the image each time the widget is built
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}