import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../constants.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'noConnection2'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontFamily: normsProRegular, fontSize: 18),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(borderRadius: borderRadius10),
                backgroundColor: kPrimaryColor,
              ),
              child: Text(
                'noConnection3'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
