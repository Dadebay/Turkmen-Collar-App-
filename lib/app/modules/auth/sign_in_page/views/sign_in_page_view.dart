import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/custom_text_field.dart';
import 'package:yaka2/app/constants/phone_number.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/services/login_sig_in_service.dart';
import 'package:yaka2/app/modules/auth/sign_in_page/controllers/sign_in_page_controller.dart';
import 'package:yaka2/app/modules/auth/sign_in_page/views/otp_check.dart';
import 'package:yaka2/app/others/buttons/agree_button.dart';

class SignInView extends GetView {
  TextEditingController fullNameController = TextEditingController();
  FocusNode fullNameFocusNode = FocusNode();
  TextEditingController idController = TextEditingController();
  FocusNode idFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberFocusNode = FocusNode();
  final _signUp = GlobalKey<FormState>();
  final SignInPageController signInPageController = Get.put(SignInPageController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
      ),
      child: Form(
        key: _signUp,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 14, top: 12),
                child: Text(
                  'signInDialog'.tr,
                  style: const TextStyle(color: Colors.black, fontFamily: normsProMedium, fontSize: 20),
                ),
              ),
              CustomTextField(labelName: 'signIn1', controller: fullNameController, focusNode: fullNameFocusNode, requestfocusNode: idFocusNode, borderRadius: true, isNumber: false),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextField(labelName: 'signIn2', controller: idController, focusNode: idFocusNode, requestfocusNode: phoneNumberFocusNode, borderRadius: true, isNumber: false),
              ),
              PhoneNumber(
                mineFocus: phoneNumberFocusNode,
                controller: phoneNumberController,
                requestFocus: fullNameFocusNode,
                style: false,
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: AgreeButton(
                  onTap: () {
                    if (_signUp.currentState!.validate()) {
                      signInPageController.agreeButton.value = !signInPageController.agreeButton.value;
                      SignInService().login(phone: '+993${phoneNumberController.text}').then((value) {
                        if (value == 200) {
                          Get.to(() => OtpCheck(phoneNumber: phoneNumberController.text));
                          signInPageController.saveUserName(fullNameController.text, idController.text);
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
