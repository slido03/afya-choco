import 'package:flutter/material.dart';

/*
 * This class is used to display the banner image
 * in the banner-carousel
*/
class BannerImg extends StatelessWidget {
  final String imagePath;

  const BannerImg({super.key, required this.imagePath});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: double.infinity,
      decoration:  BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}