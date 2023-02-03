import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/custom_text_field.dart';
import 'package:yaka2/app/constants/phone_number.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/services/order_service.dart';
import 'package:yaka2/app/modules/auth/sign_in_page/controllers/sign_in_page_controller.dart';
import 'package:yaka2/app/modules/cart/controllers/cart_controller.dart';
import 'package:yaka2/app/others/buttons/agree_button.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final SignInPageController signInPageController = Get.put(SignInPageController());
  final CartController cartController = Get.put(CartController());
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final FocusNode orderAdressFocusNode = FocusNode();
  final FocusNode orderUserName = FocusNode();
  final FocusNode orderPhoneNumber = FocusNode();
  final FocusNode orderNote = FocusNode();
  final orderPage = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarIconBrightness: Brightness.dark),
        centerTitle: true,
        title: Text(
          'orderProducts'.tr,
          style: const TextStyle(fontFamily: normProBold, color: Colors.black),
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
      body: Form(
        key: orderPage,
        child: ListView(
          padding: const EdgeInsets.all(15.0),
          children: [
            textpart('userName', true),
            CustomTextField(
              labelName: 'userName',
              controller: userNameController,
              focusNode: orderUserName,
              requestfocusNode: orderPhoneNumber,
              isNumber: false,
              maxline: 1,
              borderRadius: true,
            ),
            textpart('phoneNumber', false),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: PhoneNumber(mineFocus: orderPhoneNumber, controller: phoneController, requestFocus: orderAdressFocusNode, style: false),
            ),
            textpart('selectCityTitle', true),
            selectCity(),
            textpart('orderAdress', false),
            CustomTextField(
              labelName: 'orderAdress',
              controller: addressController,
              focusNode: orderAdressFocusNode,
              requestfocusNode: orderNote,
              isNumber: false,
              borderRadius: true,
              maxline: 4,
            ),
            textpart('note', false),
            CustomTextField(
              labelName: 'note',
              controller: noteController,
              focusNode: orderNote,
              requestfocusNode: orderUserName,
              isNumber: false,
              maxline: 4,
              borderRadius: true,
            ),
            const SizedBox(
              height: 40,
            ),
            AgreeButton(
              onTap: () {
                final List list = [];
                if (orderPage.currentState!.validate()) {
                  for (var element in cartController.list) {
                    list.add({'id': element['id'], 'quantity': element['quantity']});
                  }
                  signInPageController.agreeButton.value = !signInPageController.agreeButton.value;

                  OrderService().createOrder(products: list, note: noteController.text, customerName: userNameController.text, address: addressController.text, province: name, phone: phoneController.text).then((value) {
                    if (value == true) {
                      showSnackBar('copySucces', 'orderSubtitle', Colors.green);

                      cartController.removeAllCartElements();
                    } else {
                      showSnackBar('noConnection3', 'error', Colors.red);
                    }
                    signInPageController.agreeButton.value = !signInPageController.agreeButton.value;
                  });
                  Get.back();
                  Get.back();
                } else {
                  showSnackBar('noConnection3', 'errorEmpty', Colors.red);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  String name = 'Asgabat';

  Padding selectCity() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: Text(name.tr, style: const TextStyle(color: Colors.black, fontFamily: normsProMedium, fontSize: 18)),
        shape: const RoundedRectangleBorder(borderRadius: borderRadius15),
        tileColor: kGreyColor.withOpacity(0.4),
        trailing: const Icon(IconlyLight.arrowRightCircle),
        onTap: () {
          Get.defaultDialog(
            title: 'selectCityTitle'.tr,
            titleStyle: const TextStyle(color: Colors.black, fontFamily: normsProMedium),
            radius: 5,
            backgroundColor: Colors.white,
            titlePadding: const EdgeInsets.symmetric(vertical: 20),
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
                        name = cities[index];
                        setState(() {});
                        Get.back();
                      },
                      child: Text(
                        '${cities[index]}',
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
