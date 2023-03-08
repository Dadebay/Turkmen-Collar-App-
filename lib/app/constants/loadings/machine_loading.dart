import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import 'loading.dart';

class MachineLoading extends StatelessWidget {
  const MachineLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: Get.size.width / 1.2,
          margin: const EdgeInsets.only(left: 15, bottom: 5),
          decoration: const BoxDecoration(borderRadius: borderRadius15, color: kGreyColor),
          child: Loading(),
        );
      },
    );
    ;
  }
}
