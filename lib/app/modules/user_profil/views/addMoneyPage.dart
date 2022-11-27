// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/data/services/file_download_service.dart';

class AddCash extends StatefulWidget {
  AddCash({Key? key}) : super(key: key);

  @override
  State<AddCash> createState() => _AddCashState();
}

class _AddCashState extends State<AddCash> {
  int value = 0;
  List moneyList = [10, 20, 30, 40, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
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
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await launch('tel://++99364030911');
            },
            icon: Icon(
              IconlyLight.call,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SizedBox(
        width: Get.size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'addMoneyTitle'.tr,
                style: TextStyle(fontFamily: normsProRegular, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'addMoneySubTitle'.tr,
                style: TextStyle(fontFamily: normProBold, color: Colors.red, fontSize: 20),
              ),
            ),
            Container(
              height: 300,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return RadioListTile(
                    value: index,
                    activeColor: kPrimaryColor,
                    groupValue: value,
                    onChanged: (int? ind) => setState(() => value = ind!),
                    title: Text(
                      '${moneyList[index]} TMT',
                      style: TextStyle(color: Colors.black, fontFamily: normProBold, fontSize: 18),
                    ),
                  );
                },
                itemCount: 5,
              ),
            ),
            GestureDetector(
              onTap: () {
                value = 0;
                Get.defaultDialog(
                  title: 'sendMoney'.tr,
                  titleStyle: TextStyle(color: Colors.black, fontSize: 20, fontFamily: normsProMedium),
                  content: StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        height: Get.size.height - 200,
                        width: Get.size.width,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemExtent: 70,
                                itemBuilder: (context, index) {
                                  return RadioListTile(
                                    value: index,
                                    activeColor: kPrimaryColor,
                                    groupValue: value,
                                    onChanged: (int? ind) => setState(() {
                                      value = ind!;
                                    }),
                                    title: Text(
                                      '${moneyList[index]} TMT',
                                      style: TextStyle(color: Colors.black, fontFamily: normProBold, fontSize: 18),
                                    ),
                                  );
                                },
                                itemCount: moneyList.length,
                              ),
                            ),
                            sendMoneyButton(true),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
              child: Container(
                width: Get.size.width,
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.8),
                  borderRadius: borderRadius10,
                ),
                child: Text(
                  'addMoneyButton'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: normProBold),
                ),
              ),
            ),
            Spacer(),
            sendMoneyButton(false),
          ],
        ),
      ),
    );
  }

  Container sendMoneyButton(bool margin) {
    return Container(
      width: Get.size.width,
      margin: margin ? EdgeInsets.only(left: 15, right: 15, top: 10) : EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ElevatedButton(
        onPressed: () async {
          await FileDownloadService().getAvailabePhoneNumber().then((element) async {
            if (Platform.isAndroid) {
              final uri = 'sms:0804?body=${element['phone']}   ${moneyList[value]} ';
              await launch(uri);
            } else if (Platform.isIOS) {
              final uri = 'sms:0804&body=${element['phone']}   ${moneyList[value]} ';
              await launch(uri);
            }
          });
        },
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
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
