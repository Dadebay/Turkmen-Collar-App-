import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';

Widget twoTextEditingField({required TextEditingController controller1, required TextEditingController controller2}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 20),
          child: Text('priceRange'.tr, style: const TextStyle(fontFamily: normsProRegular, fontSize: 19, color: Colors.black)),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                style: const TextStyle(fontFamily: normsProMedium, fontSize: 18),
                cursorColor: kPrimaryColor,
                controller: controller1,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(9),
                ],
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text('TMT', textAlign: TextAlign.center, style: TextStyle(fontFamily: normProBold, fontSize: 14, color: Colors.grey.shade400)),
                  ),
                  suffixIconConstraints: const BoxConstraints(minHeight: 15),
                  isDense: true,
                  hintText: 'minPrice'.tr,
                  hintStyle: TextStyle(fontFamily: normsProMedium, fontSize: 16, color: Colors.grey.shade400),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: borderRadius15,
                    borderSide: BorderSide(color: kPrimaryColor, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: borderRadius15,
                    borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
                  ),
                ),
              ),
            ),
            Container(
              width: 15,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              height: 2,
              color: Colors.grey,
            ),
            Expanded(
              child: TextFormField(
                style: const TextStyle(fontFamily: normsProMedium, fontSize: 18),
                cursorColor: kPrimaryColor,
                controller: controller2,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  // LengthLimitingTextInputFormatter(9),
                ],
                decoration: InputDecoration(
                  suffixIcon: Padding(padding: const EdgeInsets.only(right: 8), child: Text('TMT', textAlign: TextAlign.center, style: TextStyle(fontFamily: normProBold, fontSize: 14, color: Colors.grey.shade400))),
                  suffixIconConstraints: const BoxConstraints(minHeight: 15),
                  isDense: true,
                  hintText: 'maxPrice'.tr,
                  hintStyle: TextStyle(fontFamily: normsProMedium, fontSize: 16, color: Colors.grey.shade400),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: borderRadius15,
                    borderSide: BorderSide(color: kPrimaryColor, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: borderRadius15,
                    borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
