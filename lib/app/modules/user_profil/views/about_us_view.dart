import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/data/models/about_us_model.dart';
import 'package:yaka2/app/data/services/about_us_service.dart';

import '../../../constants/widgets.dart';

class AboutUsView extends GetView {
  const AboutUsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        elevation: 0,
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
          'aboutUS'.tr,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<AboutUsModel>(
        future: AboutUsService().getAboutUs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (snapshot.hasError) {
            return const Text('error');
          } else if (snapshot.data == null) {
            return const Text('null');
          }
          return Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'contactInformation'.tr,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Text(
                  snapshot.data!.body!,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
