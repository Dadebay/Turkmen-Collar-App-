import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yaka2/app/constants/empty_state/empty_state_text.dart';
import 'package:yaka2/app/constants/error_state/error_state.dart';
import 'package:yaka2/app/constants/loadings/collar_loading.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';
import 'package:yaka2/app/others/cards/product_card.dart';

import '../../../constants/constants.dart';

class ListviewClothesView extends GetView {
  final HomeController clothesController = Get.put(HomeController());
  final RefreshController refreshController = RefreshController();
  ListviewClothesView({Key? key}) : super(key: key);

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.loadComplete();
    clothesController.clothesPage.value += 1;
    clothesController.clothesLimit.value = 10;
    clothesController.getDataClothes();
    refreshController.refreshCompleted();
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
              controller: refreshController,
              onLoading: _onLoading,
              enablePullDown: false,
              enablePullUp: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              header: const MaterialClassicHeader(
                color: kPrimaryColor,
              ),
              child: Obx(
                () {
                  if (clothesController.clothesLoading.value == 0) {
                    return CollarLoading();
                  } else if (clothesController.clothesLoading.value == 1) {
                    return ErrorState(
                      onTap: () {
                        clothesController.getDataClothes();
                      },
                    );
                  } else if (clothesController.clothesLoading.value == 2) {
                    return EmptyStateText();
                  }
                  return ListView.builder(
                    itemCount: clothesController.clothesList.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    addAutomaticKeepAlives: true,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(
                        image: clothesController.clothesList[index]['images'],
                        name: clothesController.clothesList[index]['name'],
                        price: clothesController.clothesList[index]['price'].toString(),
                        id: int.parse(clothesController.clothesList[index]['id'].toString()),
                        downloadable: false,
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
