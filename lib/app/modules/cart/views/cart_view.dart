import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/services/auth_service.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              cartController.removeAllCartElements();
            },
            icon: Icon(
              IconlyLight.delete,
              color: Colors.black,
            ),
          )
        ],
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
      body: Obx(() {
        return Column(
          children: [
            cartController.list.isEmpty
                ? emptyCart()
                : Expanded(
                    child: ListView.builder(
                      itemCount: cartController.list.length,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
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
            orderDetail()
          ],
        );
      }),
    );
  }

  Container orderDetail() {
    double sum = 0;
    cartController.list.forEach((element) {
      double a = double.parse(element['price']);
      a *= element['quantity'];
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
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'countProducts'.tr,
                  style: TextStyle(fontFamily: normsProRegular, fontSize: 18),
                ),
                Text(
                  cartController.list.length.toString(),
                  style: TextStyle(fontFamily: normProBold, fontSize: 20),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'priceProduct'.tr,
                  style: TextStyle(fontFamily: normsProRegular, fontSize: 18),
                ),
                Text(
                  '${sum} TMT',
                  style: TextStyle(fontFamily: normProBold, fontSize: 20),
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final token = await Auth().getToken();
              if (token == null || token == '') {
                showSnackBar('loginError', 'loginErrorSubtitle', Colors.red);
              } else {
                if (cartController.list.isNotEmpty) {
                  await Get.to(() => OrderPage());
                } else {
                  showSnackBar('emptyCart', 'emptyCartSubtitle', Colors.red);
                }
              }
            },
            style: ElevatedButton.styleFrom(primary: kPrimaryColor, shape: RoundedRectangleBorder(borderRadius: borderRadius15), padding: EdgeInsets.symmetric(vertical: 15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'orderProducts'.tr,
                  style: TextStyle(color: Colors.white, fontFamily: normsProMedium, fontSize: 19),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Icon(
                    IconlyBroken.arrowRightCircle,
                    color: Colors.white,
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
