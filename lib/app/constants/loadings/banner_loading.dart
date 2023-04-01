import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../constants.dart';
import 'loading.dart';

class BannerLoading extends StatelessWidget {
  const BannerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: Get.size.height / 4,
      width: Get.size.width,
      decoration: const BoxDecoration(borderRadius: borderRadius15, color: kGreyColor),
      child: Loading(),
    );
  }
}
