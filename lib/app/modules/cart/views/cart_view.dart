import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/others/cards/cart_card.dart';

import '../controllers/cart_controller.dart';
import 'order_page.dart';

class CartView extends GetView<CartController> {
  final CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarIconBrightness: Brightness.dark),
        centerTitle: true,
        title: Text(
          'cart'.tr,
          style: TextStyle(fontFamily: normProBold, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            IconlyLight.arrowLeftCircle,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      bottomSheet: orderDetail(),
      body: Column(
        children: [
          Divider(
            color: kPrimaryColor,
          ),
          Expanded(
            child: cartController.list.isEmpty
                ? Center(
                    child: Text('Bos Sebet'),
                  )
                : ListView.builder(
                    itemCount: cartController.list.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final double a = double.parse(cartController.list[index]['price']);
                      return CardCart(
                        createdAt: cartController.list[index]['createdAt'] ?? '0.0.0',
                        name: cartController.list[index]['name'] ?? 'Ady',
                        id: cartController.list[index]['id'] ?? 1,
                        price: '${a / 100}',
                        image: cartController.list[index]['image'] ?? '0',
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Container orderDetail() {
    double sum = 0;

    cartController.list.forEach((element) {
      final double a = double.parse(element['price']);
      sum += a / 100;
    });
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: kPrimaryColor,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Count',
              ),
              Text(
                cartController.list.length.toString(),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price all',
              ),
              Text(
                '${sum} TMT',
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => OrderPage());
            },
            style: ElevatedButton.styleFrom(primary: kPrimaryColor),
            child: Row(
              children: [
                Text(
                  'Order',
                  style: TextStyle(color: Colors.black, fontFamily: normsProMedium, fontSize: 19),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Icon(
                    IconlyBroken.arrowRightCircle,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
