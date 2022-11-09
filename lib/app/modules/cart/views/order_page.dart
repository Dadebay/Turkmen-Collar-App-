import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/modules/cart/controllers/cart_controller.dart';
import 'package:yaka2/app/others/buttons/agree_button.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final CartController cartController = Get.put(CartController());
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
        centerTitle: true,
        title: Text(
          'order'.tr,
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
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          selectCity(),
          AgreeButton(
            onTap: () {},
          )
        ],
      ),
    );
  }

  Padding selectCity() {
    final String name = 'Asgabat';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('selectCityTitle'.tr, style: const TextStyle(color: Colors.grey, fontFamily: normsProMedium, fontSize: 14)),
            Text(name.tr, style: const TextStyle(color: Colors.black, fontFamily: normsProMedium, fontSize: 18)),
          ],
        ),
        leading: const Icon(
          IconlyLight.location,
          size: 30,
        ),
        trailing: const Icon(IconlyLight.arrowRightCircle),
        onTap: () {
          Get.defaultDialog(
            title: 'selectCityTitle'.tr,
            titleStyle: const TextStyle(color: Colors.black, fontFamily: normsProMedium),
            radius: 5,
            backgroundColor: Colors.white,
            titlePadding: const EdgeInsets.symmetric(vertical: 20),
            contentPadding: const EdgeInsets.only(),
            content: Column(
              children: List.generate(
                cities.length,
                (index) => Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    divider(),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        '${çities[index]}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black, fontFamily: normsProMedium, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
