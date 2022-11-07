// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/custom_text_field.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/services/login_sig_in_service.dart';
import 'package:yaka2/app/modules/auth/connection_check/views/connection_check.dart';
import 'package:yaka2/app/others/buttons/agree_button.dart';

class OtpCheck extends StatelessWidget {
  final String phoneNumber;
  OtpCheck({
    required this.phoneNumber,
  });
  FocusNode otpFocusNode = FocusNode();
  final otpCheck = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

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
          style: TextStyle(fontFamily: normProBold, color: Colors.black),
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
      // appBar: const MyAppBar(fontSize: 0.0, backArrow: true, iconRemove: false, name: 'otp', elevationWhite: false),
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
                style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: normsProMedium),
              ),
            ),
            Form(key: otpCheck, child: CustomTextField(labelName: 'otp', controller: otpController, focusNode: otpFocusNode, requestfocusNode: otpFocusNode, borderRadius: true, isNumber: true)),
            const SizedBox(
              height: 15,
            ),
            AgreeButton(
              onTap: () {
                if (otpCheck.currentState!.validate()) {
                  SignInService().otpCheck(otp: otpController.text, phoneNumber: '+993${phoneNumber}').then((value) {
                    if (value == true) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => ConnectionCheckpage(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      showSnackBar('noConnection3', 'tournamentInfo14', Colors.red);
                    }
                  });
                } else {
                  showSnackBar('tournamentInfo14', 'signInDialog', Colors.red);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
