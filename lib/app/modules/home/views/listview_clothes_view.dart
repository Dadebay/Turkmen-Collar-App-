import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/banner_model.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';

import '../../cards/home_product_card.dart';

class ListviewClothesView extends GetView {
  ListviewClothesView({Key? key}) : super(key: key);
  final HomeController bannerController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BannerModel>>(
      future: bannerController.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: spinKit());
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.data!.isEmpty) {
          return const Text('No Kategory Image');
        }
        return Container(
          height: 290,
          margin: const EdgeInsets.only(top: 25),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              namePart(text: 'womenClothes'),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return HomePageCard(
                      index: index,
                      second: true,
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
