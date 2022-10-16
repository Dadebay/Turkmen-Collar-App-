import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/banner_model.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';
import 'package:yaka2/app/modules/home/views/show_all_products_view.dart';

class CategoryView extends GetView {
  @override
  final HomeController controller = Get.put(HomeController());
  CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BannerModel>>(
      future: controller.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: spinKit());
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.data!.isEmpty) {
          return const Text('No Kategory Image');
        }
        return CarouselSlider.builder(
          itemCount: 8,
          itemBuilder: (context, index, count) {
            return GestureDetector(
              onTap: () {
                Get.to(() => ShowAllProductsView(categoryName[index]));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 25, bottom: 10),
                child: ClipRRect(
                  borderRadius: borderRadius10,
                  child: Image.asset(
                    'assets/image/category/${index + 1}.png',
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
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
      },
    );
  }
}
