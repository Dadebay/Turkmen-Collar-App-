import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sign_in_page_controller.dart';

class SignInPageView extends GetView<SignInPageController> {
  const SignInPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignInPageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SignInPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
