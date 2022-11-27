import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/others/product_profil/views/photo_view.dart';

class InstructionPage extends StatelessWidget {
  const InstructionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarIconBrightness: Brightness.dark),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            IconlyLight.arrowLeftCircle,
            color: Colors.black,
          ),
        ),
        title: Text(
          'insPage'.tr,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: CarouselSlider.builder(
        itemCount: 4,
        itemBuilder: (context, index, count) {
          return GestureDetector(
            onTap: () {
              Get.to(
                () => PhotoViewPage(
                  image: 'assets/image/instruction/${index + 1}.png',
                  networkImage: false,
                ),
              );
            },
            child: Image.asset(
              'assets/image/instruction/${index + 1}.png',
              fit: BoxFit.contain,
            ),
          );
        },
        options: CarouselOptions(
          onPageChanged: (index, CarouselPageChangedReason a) {},
          height: Get.size.height,
          viewportFraction: 0.8,
          autoPlay: true,
          scrollPhysics: const BouncingScrollPhysics(),
          autoPlayCurve: Curves.fastLinearToSlowEaseIn,
          autoPlayAnimationDuration: const Duration(milliseconds: 2000),
        ),
      ),
    );
  }
}
