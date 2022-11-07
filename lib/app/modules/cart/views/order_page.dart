import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
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
  String userName = 'Ulanyjy ady';
  String note = 'Note';
  String address = 'address';
  String phone = 'phone';
  String city = 'city';
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
          ListTile(
            onTap: () {
              dialog(userName, userNameController, 1);
            },
            trailing: Icon(IconlyLight.arrowRightCircle),
            leading: Icon(IconlyLight.profile),
            title: Text('username'),
            selectedColor: kPrimaryColor,
            tileColor: kPrimaryColor,
            shape: RoundedRectangleBorder(borderRadius: borderRadius20),
          ),
          ListTile(
            onTap: () {
              dialog(note, noteController, 2);
            },
            trailing: Icon(IconlyLight.arrowRightCircle),
            leading: Icon(IconlyLight.profile),
            title: Text('note'),
            selectedColor: kPrimaryColor,
            tileColor: kPrimaryColor,
            shape: RoundedRectangleBorder(borderRadius: borderRadius20),
          ),
          ListTile(
            onTap: () {
              dialog(address, addressController, 3);
            },
            trailing: Icon(IconlyLight.arrowRightCircle),
            leading: Icon(IconlyLight.profile),
            title: Text('address'),
            selectedColor: kPrimaryColor,
            tileColor: kPrimaryColor,
            shape: RoundedRectangleBorder(borderRadius: borderRadius20),
          ),
          ListTile(
            onTap: () {
              dialog(phone, phoneController, 4);
            },
            trailing: Icon(IconlyLight.arrowRightCircle),
            leading: Icon(IconlyLight.profile),
            title: Text('phone'),
            selectedColor: kPrimaryColor,
            tileColor: kPrimaryColor,
            shape: RoundedRectangleBorder(borderRadius: borderRadius20),
          ),
          ListTile(
            onTap: () {
              dialog(city, cityController, 5);
            },
            trailing: Icon(IconlyLight.arrowRightCircle),
            leading: Icon(IconlyLight.profile),
            title: Text('city'),
            selectedColor: kPrimaryColor,
            tileColor: kPrimaryColor,
            shape: RoundedRectangleBorder(borderRadius: borderRadius20),
          ),
          AgreeButton(onTap: () {})
        ],
      ),
    );
  }

  Future<dynamic> dialog(String name, TextEditingController controller, int which) {
    return Get.defaultDialog(
      title: name,
      content: Column(
        children: [
          TextFormField(
            controller: controller,
          ),
          AgreeButton(
            onTap: () {
              if (which == 1) {
                userName = controller.text;
              } else if (which == 2) {
                note = controller.text;
              } else if (which == 3) {
                address = controller.text;
              } else if (which == 4) {
                phone = controller.text;
              } else if (which == 5) {
                city = controller.text;
              }
              Get.back();
              setState(() {});
            },
          )
        ],
      ),
    );
  }
}
