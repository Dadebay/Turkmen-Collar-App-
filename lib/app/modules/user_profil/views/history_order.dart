// ignore_for_file: always_put_required_named_parameters_first

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/history_order_model.dart';
import 'package:yaka2/app/data/services/history_order_service.dart';
import 'package:yaka2/app/others/cards/product_card.dart';

class HistoryOrders extends StatelessWidget {
  const HistoryOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarIconBrightness: Brightness.dark),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            IconlyLight.arrowLeftCircle,
            color: Colors.black,
          ),
        ),
        title: Text(
          'orders'.tr,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<HistoryOrderModel>>(
        future: HistoryOrderService().getHistoryOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (snapshot.hasError) {
            return errorPage(
              onTap: () {
                HistoryOrderService().getHistoryOrders();
              },
            );
          } else if (snapshot.data == null) {
            return emptyPageImage(
              onTap: () {
                HistoryOrderService().getHistoryOrders();
              },
            );
          }
          return ListView.separated(
            itemCount: snapshot.data!.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  Get.to(
                    () => HistoryOrderProductID(
                      id: snapshot.data![index].id!,
                      index: index,
                    ),
                  );
                },
                minVerticalPadding: 0.0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'order'.tr + ' ${snapshot.data!.length - index}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: normsProMedium,
                      ),
                    ),
                    Text(
                      snapshot.data![index].status == 'in_review' ? 'waiting'.tr : 'come'.tr,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: normsProLight,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${snapshot.data![index].totalCost! / 100}',
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 18,
                            fontFamily: normProBold,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Text(
                            ' TMT',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontFamily: normsProMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  color: Colors.grey,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class HistoryOrderProductID extends StatelessWidget {
  final int index;
  final int id;

  const HistoryOrderProductID({Key? key, required this.index, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarIconBrightness: Brightness.dark),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            IconlyLight.arrowLeftCircle,
            color: Colors.black,
          ),
        ),
        title: Text(
          'order'.tr + ' ${index + 1}'.tr,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<ProductsModelMini>>(
        future: HistoryOrderService().getHistoryOrderByID(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: spinKit(),
            );
          } else if (snapshot.hasError) {
            return errorPage(
              onTap: () {
                HistoryOrderService().getHistoryOrderByID(id);
              },
            );
          } else if (snapshot.data!.isEmpty) {
            return emptyPageImage(
              onTap: () {
                HistoryOrderService().getHistoryOrderByID(id);
                ;
              },
            );
          }
          return StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ProductCard(
                image: snapshot.data![index].image!,
                name: '${snapshot.data![index].name}',
                price: '${snapshot.data![index].price}',
                id: snapshot.data![index].id!,
                downloadable: false,
                files: [],
                removeAddCard: true,
                createdAt: '',
              );
            },
            staggeredTileBuilder: (index) => const StaggeredTile.count(1, 1.5),
          );
        },
      ),
    );
  }
}
