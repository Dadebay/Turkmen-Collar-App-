import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/error_state/error_state.dart';
import 'package:yaka2/app/constants/loadings/mini_category_loading.dart';
import 'package:yaka2/app/data/models/category_model.dart';
import 'package:yaka2/app/data/services/category_service.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';
import 'package:yaka2/app/others/cards/category_card.dart';

import '../../../constants/empty_state/empty_state_text.dart';

class CategoryView extends GetView {
  @override
  final HomeController controller = Get.put(HomeController());
  CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: controller.getCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MiniCategoryLoading();
        } else if (snapshot.hasError) {
          return ErrorState(
            onTap: () {
              CategoryService().getCategories();
            },
          );
        } else if (snapshot.data!.isEmpty) {
          return SizedBox(
            height: Get.size.height / 5,
            child: EmptyStateText(),
          );
        }
        return CarouselSlider.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index, count) {
            return CategoryCard(
              id: snapshot.data![index].id!,
              image: snapshot.data![index].image!,
              name: snapshot.data![index].name!,
            );
          },
          options: CarouselOptions(
            onPageChanged: (index, CarouselPageChangedReason a) {},
            height: Get.size.height / 5,
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
