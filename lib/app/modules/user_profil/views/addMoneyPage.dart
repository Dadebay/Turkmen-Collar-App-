import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaka2/app/constants/constants.dart';

class AddCash extends StatelessWidget {
  const AddCash({Key? key}) : super(key: key);

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
      ),
      body: SizedBox(
        width: Get.size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'message'.tr,
                style: TextStyle(fontFamily: normsProRegular, fontSize: 20),
              ),
            ),
            Container(
              width: Get.size.width,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ElevatedButton(
                onPressed: () async {
                  await launch('tel://+99364030911');
                },
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: const RoundedRectangleBorder(borderRadius: borderRadius15),
                ),
                child: Text(
                  'call'.tr,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontFamily: normsProMedium, fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
