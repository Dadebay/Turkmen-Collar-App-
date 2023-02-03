import 'package:flutter/material.dart';
import 'package:yaka2/app/constants/constants.dart';

class DownloadButton extends StatefulWidget {
  const DownloadButton({super.key});

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          if (!mounted) {
        return;
      }
        setState(() {
          
          value = !value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.only(right: 4, top: 5),
        decoration: BoxDecoration(
          borderRadius: borderRadius5,
          color: kPrimaryColor.withOpacity(0.3),
        ),
        child: const Icon(
          Icons.download_rounded,
          color: kPrimaryColor,
          size: 28,
        ),
      ),
    );
  }
}
