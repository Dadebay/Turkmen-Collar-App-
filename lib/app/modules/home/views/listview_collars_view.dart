import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/banner_model.dart';
import 'package:yaka2/app/modules/cards/home_product_card.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';

class ListviewCollarsView extends GetView {
  final HomeController bannerController = Get.put(HomeController());

  ListviewCollarsView({Key? key}) : super(key: key);
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
          margin: const EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              namePart(text: 'collars'),
              Expanded(
                child: ListView.builder(
                  itemCount: 13,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return HomePageCard(
                      index: index,
                      second: false,
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
