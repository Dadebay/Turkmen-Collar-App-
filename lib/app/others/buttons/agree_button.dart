// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/modules/auth/sign_in_page/controllers/sign_in_page_controller.dart';

class AgreeButton extends StatelessWidget {
  final Function() onTap;

  AgreeButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final SignInPageController signInPageController = Get.put(SignInPageController());

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
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: signInPageController.agreeButton.value ? 0 : 8),
      width: signInPageController.agreeButton.value ? 60 : Get.size.width,
      duration: const Duration(milliseconds: 1000),
      child: signInPageController.agreeButton.value
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
              style: const TextStyle(color: Colors.white, fontFamily: normsProMedium, fontSize: 20),
            ),
    );
  }
}
