import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';

import 'login_view.dart';
import 'sign_in_page_view.dart';

class TabbarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              IconlyLight.arrowLeftCircle,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarIconBrightness: Brightness.dark),
        ),
        body: Stack(
          children: [
            SizedBox(
              width: Get.size.width,
              height: Get.size.height / 2.8,
              child: ClipRRect(
                borderRadius: borderRadius30,
                child: Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    padding: EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: borderRadius30,
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      logo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: Get.size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.only(
                          left: 8,
                        ),
                        child: TabBar(
                          indicatorSize: TabBarIndicatorSize.label,
                          isScrollable: true,
                          indicatorColor: Colors.black,
                          automaticIndicatorColorAdjustment: true,
                          labelStyle: const TextStyle(fontFamily: normsProMedium, fontSize: 22),
                          unselectedLabelStyle: const TextStyle(fontFamily: normsProMedium),
                          labelColor: Colors.black,
                          indicatorWeight: 4,
                          indicatorPadding: const EdgeInsets.only(top: 45),
                          indicator: const BoxDecoration(color: Colors.black, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                          unselectedLabelColor: Colors.white54,
                          tabs: [
                            Tab(
                              text: 'signUp'.tr,
                            ),
                            Tab(
                              text: 'login'.tr,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TabBarView(
                        children: [SignInView(), LogInView()],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
