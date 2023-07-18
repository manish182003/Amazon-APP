import 'package:amazon_app/constants/global%20variable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class carouselimage extends StatelessWidget {
  const carouselimage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: globalvariable.carouselImages.map(
        (i) {
          return Builder(
            builder: (BuildContext context) => Image.network(
              i,
              fit: BoxFit.cover,
              height: 200,
            ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200,
      ),
    );
  }
}
