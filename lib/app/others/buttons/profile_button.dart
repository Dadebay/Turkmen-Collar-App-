// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';

class ProfilButton extends StatelessWidget {
  final String name;
  final Function() onTap;
  final IconData icon;
  final Widget? langIcon;
  final bool? langIconStatus;
  const ProfilButton({
    required this.name,
    required this.onTap,
    required this.icon,
    this.langIcon,
    this.langIconStatus,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      // tileColor: Colors.white,
      minVerticalPadding: 23,
      title: Text(
        name.tr,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(
          color: kBlackColor,
        ),
      ),
      leading: langIconStatus!
          ? langIcon
          : Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: kPrimaryColor.withOpacity(0.8), borderRadius: borderRadius15),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
      trailing: const Icon(
        IconlyLight.arrowRightCircle,
        color: kPrimaryColor,
      ),
    );
  }
}
