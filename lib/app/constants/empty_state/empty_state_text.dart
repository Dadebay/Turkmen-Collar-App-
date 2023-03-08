import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class EmptyStateText extends StatelessWidget {
  const EmptyStateText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'noData1'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontFamily: normsProRegular, fontSize: 18),
        ),
      ),
    );
  }
}
