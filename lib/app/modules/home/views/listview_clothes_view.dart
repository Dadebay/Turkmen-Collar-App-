import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/collar_model.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';

import '../../cards/home_product_card.dart';

class ListviewClothesView extends GetView {
  ListviewClothesView({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CollarModel>>(
      future: homeController.dresses,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: spinKit());
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.data!.isEmpty) {
          return const Text('No Kategory Image');
        }
        print(snapshot.error);
        return Container(
          height: 320,
          margin: const EdgeInsets.only(top: 25),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              namePart(text: 'womenClothes', onTap: () {}),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return HomePageCard(
                      image: snapshot.data![index].images!,
                      name: '${snapshot.data![index].name}',
                      price: '${snapshot.data![index].price}',
                      files: snapshot.data![index].files!,
                      id: snapshot.data![index].id!,
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
