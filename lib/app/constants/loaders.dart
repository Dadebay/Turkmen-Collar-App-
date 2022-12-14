import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';
import 'widgets.dart';

Widget loaderBanner() {
  return Container(margin: const EdgeInsets.all(8), height: 220, width: Get.size.width, decoration: BoxDecoration(borderRadius: borderRadius15, color: kGreyColor), child: Center(child: spinKit()));
}

Widget loaderCategory() {
  return CarouselSlider.builder(
    itemCount: 10,
    itemBuilder: (context, index, count) {
      return Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: borderRadius10,
          color: kGreyColor,
        ),
        child: Center(child: spinKit()),
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

Widget loaderCollar() {
  return ListView.builder(
    itemCount: 10,
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        child: Center(
          child: spinKit(),
        ),
        decoration: BoxDecoration(borderRadius: borderRadius10, color: kGreyColor),
        width: 180,
        margin: const EdgeInsets.only(left: 15, bottom: 5),
      );
    },
  );
}

Widget loaderMachines() {
  return ListView.builder(
    itemCount: 10,
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        width: Get.size.width / 1.2,
        margin: const EdgeInsets.only(left: 15, bottom: 5),
        decoration: BoxDecoration(borderRadius: borderRadius15, color: kGreyColor),
        child: Center(
          child: spinKit(),
        ),
      );
    },
  );
}
