import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/phone_number.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/services/login_sig_in_service.dart';
import 'package:yaka2/app/modules/auth/sign_in_page/controllers/sign_in_page_controller.dart';
import 'package:yaka2/app/others/buttons/agree_button.dart';

import 'otp_check.dart';

class LogInView extends GetView {
  TextEditingController fullNameController = TextEditingController();
  FocusNode fullNameFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberFocusNode = FocusNode();
  final login = GlobalKey<FormState>();
  final SignInPageController signInPageController = Get.put(SignInPageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: login,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8, right: 8, top: 25),
              child: Text(
                'signInDialog'.tr,
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.black, fontFamily: normsProMedium, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: PhoneNumber(
                mineFocus: phoneNumberFocusNode,
                controller: phoneNumberController,
                requestFocus: emailFocusNode,
                style: false,
              ),
            ),
            Center(
              child: AgreeButton(
                onTap: () {
                  if (login.currentState!.validate()) {
                    signInPageController.agreeButton.value = !signInPageController.agreeButton.value;
                    SignInService().login(phone: '+993${phoneNumberController.text}').then((value) {
                      if (value == 200) {
                        Get.to(() => OtpCheck(phoneNumber: phoneNumberController.text));
                      } else if (value == 409) {
                        showSnackBar('noConnection3', 'alreadyExist', Colors.red);
                      } else {
                        showSnackBar('noConnection3', 'errorData', Colors.red);
                      }
                    });
                    signInPageController.agreeButton.value = !signInPageController.agreeButton.value;
                  } else {
                    showSnackBar('noConnection3', 'error', Colors.red);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
