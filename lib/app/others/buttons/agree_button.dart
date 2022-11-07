// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';

class AgreeButton extends StatelessWidget {
  final Function() onTap;

  AgreeButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(() {
        return animatedContaner();
      }),
    );
  }

  AnimatedContainer animatedContaner() {
    return AnimatedContainer(
      decoration: const BoxDecoration(
        borderRadius: borderRadius20,
        color: kPrimaryColor,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: homeController.agreeButton.value ? 0 : 8),
      width: homeController.agreeButton.value ? 60 : Get.size.width,
      duration: const Duration(milliseconds: 1000),
      child: homeController.agreeButton.value
          ? const Center(
              child: SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            )
          : Text(
              'agree'.tr,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black, fontFamily: normsProMedium, fontSize: 20),
            ),
    );
  }
}
