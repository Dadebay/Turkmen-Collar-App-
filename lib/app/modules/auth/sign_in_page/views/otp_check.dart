// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/custom_text_field.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/services/login_sig_in_service.dart';
import 'package:yaka2/app/modules/auth/sign_in_page/controllers/sign_in_page_controller.dart';
import 'package:yaka2/app/modules/user_profil/controllers/user_profil_controller.dart';
import 'package:yaka2/app/others/buttons/agree_button.dart';

class OtpCheck extends StatelessWidget {
  final String phoneNumber;
  final otpCheck = GlobalKey<FormState>();

  OtpCheck({
    required this.phoneNumber,
    super.key,
  });

  TextEditingController otpController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarIconBrightness: Brightness.dark),
        centerTitle: true,
        title: Text(
          'otpCheck'.tr,
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
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'otpSubtitle'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: normsProMedium),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'waitForSms'.tr,
                style: const TextStyle(color: Colors.red, fontSize: 20, fontFamily: normsProMedium),
              ),
            ),
            Form(key: otpCheck, child: CustomTextField(labelName: 'otp', controller: otpController, focusNode: otpFocusNode, requestfocusNode: otpFocusNode, isNumber: true)),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: AgreeButton(
                onTap: () {
                  if (otpCheck.currentState!.validate()) {
                    Get.find<SignInPageController>().agreeButton.value = !Get.find<SignInPageController>().agreeButton.value;
                    SignInService().otpCheck(otp: otpController.text, phoneNumber: '+993$phoneNumber').then((value) {
                      if (value == true) {
                        Get.find<UserProfilController>().userLogin.value = true;
                        Restart.restartApp();
                      } else {
                        showSnackBar('otpErrorTitle', 'otpErrorSubtitle', Colors.red);
                      }
                      Get.find<SignInPageController>().agreeButton.value = !Get.find<SignInPageController>().agreeButton.value;
                    });
                  } else {
                    showSnackBar('noConnection3', 'errorEmpty', Colors.red);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
