import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:yaka2/app/constants/constants.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/lottie/emptyCART.json', width: 350, height: 350),
          Text(
            'cartEmpty'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontFamily: normProBold, fontSize: 20),
          ),
          Text(
            'cartEmptySubtitle'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontFamily: normsProRegular, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
