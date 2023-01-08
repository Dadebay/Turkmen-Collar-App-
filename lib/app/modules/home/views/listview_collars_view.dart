import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yaka2/app/constants/loaders.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/others/cards/product_card.dart';

import '../../../constants/constants.dart';
import '../controllers/collar_controller.dart';

class ListviewCollarsView extends StatelessWidget {
  final CollarController collarController = Get.put(CollarController());
  ListviewCollarsView({Key? key}) : super(key: key);

  final RefreshController _refreshController = RefreshController();

  void _onLoading() async {
    print('i loaded');
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
    collarController.collarPage.value += 1;
    collarController.collarLimit.value = 10;
    collarController.getData();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          namePart(
            text: 'collars',
            removeIcon: true,
            onTap: () {},
          ),
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
              child: Obx(() {
                if (collarController.collarLoading.value == 0) {
                  return loaderCollar();
                } else if (collarController.collarLoading.value == 1) {
                  return Center(
                    child: errorPage(
                      onTap: () {
                        collarController.getData();
                      },
                    ),
                  );
                } else if (collarController.collarLoading.value == 2) {
                  return Center(
                    child: emptryPageText(),
                  );
                }
                return ListView.builder(
                  itemCount: collarController.collarList.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  addAutomaticKeepAlives: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductCard(
                      image: collarController.collarList[index]['images'],
                      name: collarController.collarList[index]['name'],
                      price: collarController.collarList[index]['price'].toString(),
                      id: int.parse(collarController.collarList[index]['id'].toString()),
                      files: collarController.collarList[index]['files'],
                      downloadable: true,
                      removeAddCard: false,
                      createdAt: collarController.collarList[index]['createdAt'],
                    );
                  },
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
