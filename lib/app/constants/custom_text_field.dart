// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool? isLabel;
  final bool isNumber;
  final String labelName;
  final int? maxline;
  final FocusNode requestfocusNode;

  const CustomTextField({
    required this.labelName,
    required this.controller,
    required this.focusNode,
    required this.requestfocusNode,
    required this.isNumber,
    this.isLabel = false,
    this.maxline,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        style: const TextStyle(color: Colors.black, fontFamily: normsProMedium),
        cursorColor: Colors.black,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'errorEmpty'.tr;
          }
          return null;
        },
        onEditingComplete: () {
          requestfocusNode.requestFocus();
        },
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxline ?? 1,
        focusNode: focusNode,
        decoration: InputDecoration(
          errorMaxLines: 2,
          errorStyle: const TextStyle(fontFamily: normsProMedium),
          hintMaxLines: 5,
          helperMaxLines: 5,
          hintText: isLabel! ? labelName.tr : '',
          hintStyle: TextStyle(color: Colors.grey.shade300, fontFamily: normsProMedium),
          label: isLabel!
              ? null
              : Text(
                  labelName.tr,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade400, fontFamily: normsProMedium),
                ),
          contentPadding: const EdgeInsets.only(left: 25, top: 20, bottom: 20, right: 10),
          border: OutlineInputBorder(
            borderRadius: borderRadius20,
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius20,
            borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius20,
            borderSide: const BorderSide(color: kPrimaryColor, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius20,
            borderSide: const BorderSide(color: kPrimaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius20,
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}
