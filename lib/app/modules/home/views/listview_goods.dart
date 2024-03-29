import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/empty_state/empty_state_text.dart';
import 'package:yaka2/app/constants/error_state/error_state.dart';
import 'package:yaka2/app/constants/loadings/collar_loading.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';
import 'package:yaka2/app/others/cards/product_card.dart';

class ListViewGoods extends GetView {
  final HomeController goodsController = Get.put(HomeController());

  final RefreshController refreshController1 = RefreshController();

  ListViewGoods({super.key});

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController1.loadComplete();
    goodsController.goodsPage.value += 1;
    goodsController.goodsLimit.value = 10;
    goodsController.getDataGoods();
    refreshController1.refreshCompleted();
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
          namePart(text: 'listview_goods', onTap: () {}, removeIcon: true),
          Expanded(
            child: SmartRefresher(
              footer: footer(),
              controller: refreshController1,
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
                  if (goodsController.goodsLoading.value == 0) {
                    return CollarLoading();
                  } else if (goodsController.goodsLoading.value == 1) {
                    return ErrorState(
                      onTap: () {
                        goodsController.getDataGoods();
                      },
                    );
                  } else if (goodsController.goodsLoading.value == 2) {
                    return EmptyStateText();
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    addAutomaticKeepAlives: true,
                    itemCount: goodsController.goodsList.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      final double a = double.parse(goodsController.goodsList[index]['price'].toString());
                      final double b = a / 100.0;
                      return ProductCard(
                        categoryName: 'listview_goods'.tr,
                        image: goodsController.goodsList[index]['images'],
                        name: goodsController.goodsList[index]['name'],
                        price: b.toString(),
                        id: int.parse(goodsController.goodsList[index]['id'].toString()),
                        downloadable: false,
                        createdAt: goodsController.goodsList[index]['createdAt'],
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
