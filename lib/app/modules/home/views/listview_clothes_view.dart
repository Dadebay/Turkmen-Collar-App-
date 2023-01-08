import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yaka2/app/constants/loaders.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/modules/home/controllers/collar_controller.dart';
import 'package:yaka2/app/others/cards/product_card.dart';

import '../../../constants/constants.dart';

class ListviewClothesView extends GetView {
  ListviewClothesView({Key? key}) : super(key: key);
  final ClothesController clothesController = Get.put(ClothesController());

  final RefreshController _refreshController = RefreshController();

  void _onLoading() async {
    print('i loaded');
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
    clothesController.clothesPage.value += 1;
    clothesController.clothesLimit.value = 10;
    clothesController.getDataClothes();
    _refreshController.refreshCompleted();
  }

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
            child: SmartRefresher(
              footer: footer(),
              controller: _refreshController,
              onLoading: _onLoading,
              enablePullDown: false,
              enablePullUp: true,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              header: const MaterialClassicHeader(
                color: kPrimaryColor,
              ),
              child: Obx(
                () {
                  if (clothesController.clothesLoading.value == 0) {
                    return loaderCollar();
                  } else if (clothesController.clothesLoading.value == 1) {
                    return Center(
                      child: errorPage(
                        onTap: () {
                          clothesController.getDataClothes();
                        },
                      ),
                    );
                  } else if (clothesController.clothesLoading.value == 2) {
                    return Center(
                      child: emptryPageText(),
                    );
                  }
                  return ListView.builder(
                    itemCount: clothesController.clothesList.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(
                        image: clothesController.clothesList[index]['images'],
                        name: clothesController.clothesList[index]['name'],
                        price: clothesController.clothesList[index]['price'].toString(),
                        id: int.parse(clothesController.clothesList[index]['id'].toString()),
                        downloadable: false,
                        files: [],
                        removeAddCard: false,
                        createdAt: clothesController.clothesList[index]['createdAt'],
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
