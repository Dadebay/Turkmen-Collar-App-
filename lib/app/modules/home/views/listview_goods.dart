import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yaka2/app/constants/loaders.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/modules/home/controllers/collar_controller.dart';
import 'package:yaka2/app/others/cards/product_card.dart';

import '../../../constants/constants.dart';

class ListViewGoods extends GetView {
  final GoodsController goodsController = Get.put(GoodsController());

  final RefreshController _refreshController = RefreshController();

  void _onLoading() async {
    print('i loaded');
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
    goodsController.goodsPage.value += 1;
    goodsController.goodsLimit.value = 10;
    goodsController.getDataGoods();
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
          namePart(text: 'listview_goods', onTap: () {}, removeIcon: true),
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
                  if (goodsController.goodsLoading.value == 0) {
                    return loaderCollar();
                  } else if (goodsController.goodsLoading.value == 1) {
                    return Center(
                      child: errorPage(
                        onTap: () {
                          goodsController.getDataGoods();
                        },
                      ),
                    );
                  } else if (goodsController.goodsLoading.value == 2) {
                    return Center(
                      child: emptryPageText(),
                    );
                  }
                  return ListView.builder(
                    itemCount: goodsController.goodsList.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(
                        image: goodsController.goodsList[index]['images'],
                        name: goodsController.goodsList[index]['name'],
                        price: goodsController.goodsList[index]['price'].toString(),
                        id: int.parse(goodsController.goodsList[index]['id'].toString()),
                        downloadable: false,
                        files: [],
                        removeAddCard: false,
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
