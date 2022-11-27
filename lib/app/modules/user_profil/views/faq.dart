import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/about_us_model.dart';
import 'package:yaka2/app/data/services/about_us_service.dart';

class FAQ extends GetView {
  const FAQ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'questions'.tr,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<FAQModel>>(
        future: AboutUsService().getFAQ(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (snapshot.hasError) {
            return errorPage(
              onTap: () {
                AboutUsService().getFAQ();
              },
            );
          } else if (snapshot.data == null) {
            return emptyPageImage(
              onTap: () {
                AboutUsService().getFAQ();
              },
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ExpansionTile(
                title: Text(
                  snapshot.data![index].title!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: normsProMedium,
                    fontSize: 18,
                  ),
                ),
                collapsedIconColor: Colors.black,
                iconColor: Colors.black,
                childrenPadding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 12),
                children: [
                  Text(
                    snapshot.data![index].body!,
                    style: const TextStyle(color: Colors.black45, fontSize: 16, height: 1.5, fontFamily: normsProLight),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
