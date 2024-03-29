import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/error_state/error_state.dart';
import 'package:yaka2/app/constants/loadings/banner_loading.dart';
import 'package:yaka2/app/data/models/banner_model.dart';
import 'package:yaka2/app/data/services/banner_service.dart';
import 'package:yaka2/app/others/cards/banner_card.dart';

import '../../../constants/empty_state/empty_state_text.dart';
import '../controllers/home_controller.dart';

class BannersView extends GetView {
  final HomeController bannerController = Get.put(HomeController());
  BannersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BannerModel>>(
      future: bannerController.getBanners,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return BannerLoading();
        } else if (snapshot.hasError) {
          return ErrorState(
            onTap: () {
              BannerService().getBanners();
            },
          );
        } else if (snapshot.data!.isEmpty) {
          return SizedBox(
            height: Get.size.height / 4,
            child: EmptyStateText(),
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CarouselSlider.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index, count) {
                return BannerCard(
                  image: snapshot.data![index].image!,
                  name: snapshot.data![index].title!,
                  description: snapshot.data![index].description!,
                );
              },
              options: CarouselOptions(
                onPageChanged: (index, CarouselPageChangedReason a) {
                  bannerController.bannerDotsIndex.value = index;
                },
                height: Get.size.height / 4,
                viewportFraction: 1.0,
                autoPlay: true,
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                autoPlayAnimationDuration: const Duration(milliseconds: 2000),
              ),
            ),
            dots(snapshot.data!.length)
          ],
        );
      },
    );
  }

  SizedBox dots(int length) {
    return SizedBox(
      height: 4,
      width: Get.size.width,
      child: Center(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(() {
              return dot(index);
            });
          },
        ),
      ),
    );
  }

  AnimatedContainer dot(int index) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
      height: 16,
      width: 18,
      decoration: BoxDecoration(
        color: bannerController.bannerDotsIndex.value == index ? kPrimaryColor : Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
