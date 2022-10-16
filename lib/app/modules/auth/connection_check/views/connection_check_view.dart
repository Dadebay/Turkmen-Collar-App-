import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/connection_check_controller.dart';

class ConnectionCheckView extends GetView<ConnectionCheckController> {
  const ConnectionCheckView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ConnectionCheckView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ConnectionCheckView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
