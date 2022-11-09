import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/modules/auth/sign_in_page/views/tabbar_view.dart';
import 'package:yaka2/app/modules/user_profil/views/about_us_view.dart';
import 'package:yaka2/app/others/buttons/profile_button.dart';

import '../controllers/user_profil_controller.dart';
import 'history_order.dart';
import 'instruction_view.dart';
import 'profil_settings.dart';

class UserProfilView extends StatefulWidget {
  @override
  State<UserProfilView> createState() => _UserProfilViewState();
}

class _UserProfilViewState extends State<UserProfilView> {
  final UserProfilController userProfilController = Get.put(UserProfilController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarIconBrightness: Brightness.dark),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            IconlyLight.arrowLeftCircle,
            color: Colors.black,
          ),
        ),
        title: Text(
          'profil'.tr,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(() {
        return page();
      }),
    );
  }

  ListView page() {
    return ListView(
      children: [
        ProfilButton(
          name: 'profil',
          onTap: () {
            Get.to(() => ProfilSettings());
          },
          icon: IconlyLight.profile,
          langIconStatus: false,
        ),
        ProfilButton(
          name: Get.locale!.toLanguageTag() == 'tr' ? 'Türkmen dili' : 'Rus dili',
          onTap: () {
            changeLanguage();
          },
          icon: CupertinoIcons.add,
          langIconStatus: true,
          langIcon: Container(
            width: 35,
            height: 35,
            margin: const EdgeInsets.only(top: 3),
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
            child: ClipRRect(
              borderRadius: borderRadius15,
              child: Image.asset(
                Get.locale!.toLanguageTag() == 'tr' ? tmIcon : ruIcon,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        ProfilButton(
          name: 'addMoney',
          onTap: () {
            Get.to(() => ProfilSettings());
          },
          icon: IconlyLight.wallet,
          langIconStatus: false,
        ),
        divider(),
        ProfilButton(
          name: 'orders',
          onTap: () {
            Get.to(() => const HistoryOrders());
          },
          icon: CupertinoIcons.cube_box,
          langIconStatus: false,
        ),
        ProfilButton(
          name: 'transferUSB',
          onTap: () {},
          icon: Icons.usb,
          langIconStatus: true,
          langIcon: customIcon('assets/icons/usb3.png'),
        ),
        ProfilButton(
          name: 'shareUs',
          onTap: () {
            Share.share(appShareLink, subject: appName);
          },
          icon: Icons.share,
          langIconStatus: true,
          langIcon: customIcon('assets/icons/share1.png'),
        ),
        divider(),
        ProfilButton(
          name: 'questions',
          onTap: () {
            Get.to(() => const InstructionView());
          },
          icon: IconlyLight.document,
          langIconStatus: false,
        ),
        ProfilButton(
          name: 'aboutUs',
          onTap: () {
            Get.to(() => const AboutUsView());
          },
          icon: IconlyLight.user3,
          langIconStatus: false,
        ),
        ProfilButton(
          name: userProfilController.userLogin.value ? 'log_out' : 'signUp',
          onTap: () {
            userProfilController.userLogin.value ? logOut() : Get.to(() => TabbarView());
          },
          icon: IconlyLight.login,
          langIconStatus: false,
        ),
      ],
    );
  }

  Container customIcon(String iconNmae) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: kPrimaryColor.withOpacity(0.8), borderRadius: borderRadius15),
      child: Image.asset(
        iconNmae,
        width: 24,
        height: 24,
        color: Colors.white,
      ),
    );
  }
}
