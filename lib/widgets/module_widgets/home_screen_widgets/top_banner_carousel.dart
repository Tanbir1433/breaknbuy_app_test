
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TopBannerCarousel extends StatelessWidget {
  const TopBannerCarousel({
    required this.widgetList,
    super.key, this.height,
  });

  final List<Widget> widgetList;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: widgetList,
      options: CarouselOptions(
        autoPlay: true,
        //aspectRatio: 16/9,
        viewportFraction: 1.0,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        //enlargeCenterPage: true,
        height: height ?? 300,
        autoPlayInterval: const Duration(
          seconds: 3,
        ), // Set the interval for auto-play
      ),
    );
  }
}