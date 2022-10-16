import 'package:flutter/material.dart';

import 'package:get/get.dart';

class TabbarView extends GetView {
  const TabbarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabbarView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TabbarView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
