import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/data/services/file_download_service.dart';

import '../../../constants/widgets.dart';
import '../../../data/models/auth_model.dart';
import '../../auth/sign_in_page/views/tabbar_view.dart';
import '../../home/controllers/home_controller.dart';

class AddCash extends StatefulWidget {
  const AddCash({Key? key}) : super(key: key);

  @override
  State<AddCash> createState() => _AddCashState();
}

class _AddCashState extends State<AddCash> {
  int value = 0;
  String number = '';

  final HomeController controller = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    controller.returnPhoneNumber().then((value) {
      number = value;
      setState(() {});
    });
  }

  List moneyList = [10, 20, 30, 40, 50];
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
          'addCash'.tr,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await launchUrlString('tel://++99364030911');
            },
            icon: const Icon(
              IconlyLight.call,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Text(
                  'myNumber'.tr,
                  style: const TextStyle(fontFamily: normsProMedium, fontSize: 18),
                ),
                Expanded(
                  child: Text(
                    number,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black, fontFamily: normsProMedium, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'addMoneyTitle'.tr,
              style: const TextStyle(fontFamily: normsProRegular, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'addMoneySubTitle'.tr,
              style: const TextStyle(fontFamily: normProBold, color: Colors.red, fontSize: 18),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return RadioListTile(
                value: index,
                activeColor: kPrimaryColor,
                groupValue: value,
                onChanged: (int? ind) => setState(() => value = ind!),
                title: Text(
                  '${moneyList[index]} TMT',
                  style: const TextStyle(color: Colors.black, fontFamily: normProBold, fontSize: 18),
                ),
              );
            },
            itemCount: 5,
          ),
          sendMoneyButton(false),
          SizedBox(
            height: 1000,
          )
        ],
      ),
    );
  }

  Container sendMoneyButton(bool margin) {
    return Container(
      width: Get.size.width,
      margin: margin ? const EdgeInsets.only(left: 15, right: 15, top: 10) : const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ElevatedButton(
        onPressed: () async {
          final token = await Auth().getToken();
          if (token == null || token == '') {
            showSnackBar('loginError', 'loginErrorSubtitle1', Colors.red);
            await Get.to(() => const TabbarView());
          } else {
            await FileDownloadService().getAvailabePhoneNumber().then((element) async {
              final String phoneNumber = element['data'][0];
              if (Platform.isAndroid) {
                final uri = 'sms:0804?body=$phoneNumber   ${moneyList[value]} ';
                await launchUrlString(uri);
              } else if (Platform.isIOS) {
                final uri = 'sms:0804&body=$phoneNumber   ${moneyList[value]} ';
                await launchUrlString(uri);
              }
            });
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          elevation: margin ? 0 : 1,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: const RoundedRectangleBorder(borderRadius: borderRadius15),
        ),
        child: Text(
          'sendMoney'.tr,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white, fontFamily: normsProMedium, fontSize: 22),
        ),
      ),
    );
  }
}
