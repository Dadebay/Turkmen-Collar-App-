import 'package:flutter/material.dart';
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          'aboutUS'.tr,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(14.0),
        child: FutureBuilder<AboutUsModel>(
          future: AboutUsService().getAboutUs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: spinKit());
            } else if (snapshot.hasError) {
              return const Text('error');
            } else if (snapshot.data == null) {
              return const Text('null');
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 8),
                  child: Text(
                    'contactInformation'.tr,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                simpleWidget(
                  icon: IconlyBold.message,
                  name: snapshot.data!.email!,
                ),
                simpleWidget(
                  icon: IconlyBold.location,
                  name: Get.locale?.languageCode == 'tr' ? snapshot.data!.addressTM! : snapshot.data!.addressRu!,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  ListTile simpleWidget({
    required IconData icon,
    required String name,
  }) {
    return ListTile(
      dense: true,
      onTap: () async {},
      minLeadingWidth: 10,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
      shape: const RoundedRectangleBorder(borderRadius: borderRadius5),
      leading: Icon(
        icon,
        color: kPrimaryColor,
      ),
      title: Text(
        name,
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
