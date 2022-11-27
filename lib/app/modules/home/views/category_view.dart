import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/loaders.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/category_model.dart';
import 'package:yaka2/app/data/services/category_service.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';
import 'package:yaka2/app/others/cards/category_card.dart';

class CategoryView extends GetView {
  @override
  final HomeController controller = Get.put(HomeController());
  CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: CategoryService().getCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loaderCategory();
        } else if (snapshot.hasError) {
          return errorPage(
            onTap: () {
              CategoryService().getCategories();
            },
          );
        } else if (snapshot.data!.isEmpty) {
          return Container(
            height: 170,
            child: emptryPageText(),
          );
        }
        return CarouselSlider.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index, count) {
            return CategoryCard(
              isCollar: snapshot.data![index].isCollar!,
              id: snapshot.data![index].id!,
              image: snapshot.data![index].image!,
              name: snapshot.data![index].name!,
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
