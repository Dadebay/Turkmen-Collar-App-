import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:yaka2/app/constants/constants.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(noData, width: 350, height: 350),
        Text(
          name.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontFamily: normsProRegular, fontSize: 18),
        ),
      ],
    );
  }
}
