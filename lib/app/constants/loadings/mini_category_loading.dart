import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

import '../constants.dart';
import 'loading.dart';

class MiniCategoryLoading extends StatelessWidget {
  const MiniCategoryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 10,
      itemBuilder: (context, index, count) {
        return Container(
          margin: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            borderRadius: borderRadius10,
            color: kGreyColor,
          ),
          child: Loading(),
        );
      },
      options: CarouselOptions(
        onPageChanged: (index, CarouselPageChangedReason a) {},
        height: 170,
        viewportFraction: 0.6,
        autoPlay: true,
        enableInfiniteScroll: true,
        scrollPhysics: const BouncingScrollPhysics(),
        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
        autoPlayAnimationDuration: const Duration(milliseconds: 2000),
      ),
    );
  }
}
