import 'package:flutter/material.dart';
import 'components/banner_carousel.dart';
import 'components/section_first_presentation.dart';

class ConsultationScreen extends StatelessWidget {
  const ConsultationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      //mainAxisAlignment: MainAxisAlignment.,
      children: const <Widget>[
        SizedBox(height: 5.0),
        BannerCarousel(),
        SizedBox(height: 5.0),
        Expanded(child: FirstPresentation()),
      ],
    ));
  }
}
