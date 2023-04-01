// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/phone_number.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/services/login_sig_in_service.dart';
import 'package:yaka2/app/modules/auth/sign_in_page/controllers/sign_in_page_controller.dart';
import 'package:yaka2/app/modules/auth/sign_in_page/views/otp_check.dart';
import 'package:yaka2/app/others/buttons/agree_button.dart';

class LogInView extends StatefulWidget {
  LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
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
      decoration: const BoxDecoration(
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
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 300.0,
                  maxWidth: 300.0,
                  minHeight: 30.0,
                  maxHeight: 100.0,
                ),
                child: Text(
                  'signInDialog'.tr,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: normsProMedium,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: PhoneNumber(
                mineFocus: phoneNumberFocusNode,
                controller: phoneNumberController,
                requestFocus: emailFocusNode,
              ),
            ),
            Center(
              child: AgreeButton(
                onTap: () {
                  signInPageController.agreeButton.value = !signInPageController.agreeButton.value;
                  if (login.currentState!.validate()) {
                    if (signInPageController.agreeButton.value) {
                      SignInService().login(phone: '+993${phoneNumberController.text}').then((value) {
                        if (value == 200) {
                          Get.to(() => OtpCheck(phoneNumber: phoneNumberController.text));
                          signInPageController.agreeButton.value = !signInPageController.agreeButton.value;
                        } else if (value == 409) {
                          showSnackBar('noConnection3', 'alreadyExist', Colors.red);
                          signInPageController.agreeButton.value = !signInPageController.agreeButton.value;
                        } else if (value == 429) {
                          showSnackBar('wait10MinTitle ', 'wait10Min', Colors.red);
                          signInPageController.agreeButton.value = !signInPageController.agreeButton.value;
                        } else {
                          showSnackBar('noConnection3', 'errorData', Colors.red);
                          signInPageController.agreeButton.value = !signInPageController.agreeButton.value;
                        }
                      });
                    }
                  } else {
                    showSnackBar('noConnection3', 'errorEmpty', Colors.red);
                    signInPageController.agreeButton.value = !signInPageController.agreeButton.value;
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
