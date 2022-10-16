import 'package:flutter/material.dart';

import 'package:get/get.dart';

class InstructionView extends GetView {
  const InstructionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          'profil'.tr,
        ),
      ),
      body: const Center(
        child: Text(
          'InstructionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
