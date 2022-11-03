import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/modules/auth/sign_in_page/views/tabbar_view.dart';
import 'package:yaka2/app/modules/buttons/profile_button.dart';
import 'package:yaka2/app/modules/user_profil/views/about_us_view.dart';

import '../controllers/user_profil_controller.dart';
import 'instruction_view.dart';

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
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3,
        title: Text(
          'profil'.tr,
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
          name: 'transferUSB',
          onTap: () {},
          icon: Icons.usb,
          langIconStatus: true,
          langIcon: customIcon('assets/icons/usb3.png'),
        ),
        // ProfilButton(
        //   name: 'fixMachine',
        //   onTap: () {},
        //   icon: Icons.usb,
        //   langIconStatus: true,
        //   langIcon: customIcon('assets/icons/mac8.png'),
        // ),
        ProfilButton(
          name: 'shareUs',
          onTap: () {
            Share.share(appShareLink, subject: appName);
          },
          icon: Icons.share,
          langIconStatus: true,
          langIcon: customIcon('assets/icons/share1.png'),
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
