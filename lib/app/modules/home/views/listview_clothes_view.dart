import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/loaders.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/clothes_model.dart';
import 'package:yaka2/app/data/services/dresses_service.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';
import 'package:yaka2/app/others/cards/product_card.dart';

class ListviewClothesView extends GetView {
  ListviewClothesView({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      margin: const EdgeInsets.only(top: 25),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          namePart(text: 'womenClothes', onTap: () {}, removeIcon: true),
          Expanded(
            child: FutureBuilder<List<DressesModel>>(
              future: homeController.dresses,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loaderCollar();
                } else if (snapshot.hasError) {
                  return errorPage(
                    onTap: () {
                      DressesService().getDresses();
                    },
                  );
                } else if (snapshot.data!.isEmpty) {
                  return emptryPageText();
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductCard(
                      image: snapshot.data![index].images!,
                      name: '${snapshot.data![index].name}',
                      price: '${snapshot.data![index].price}',
                      id: snapshot.data![index].id!,
                      downloadable: false,
                      files: [],
                      removeAddCard: false,
                      createdAt: snapshot.data![index].createdAt!,
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
