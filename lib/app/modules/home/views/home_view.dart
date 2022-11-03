import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/modules/auth/sign_in_page/views/tabbar_view.dart';
import 'package:yaka2/app/modules/buttons/profile_button.dart';
import 'package:yaka2/app/modules/favorites/views/favorites_view.dart';
import 'package:yaka2/app/modules/user_profil/controllers/user_profil_controller.dart';
import 'package:yaka2/app/modules/user_profil/views/downloaded_view.dart';
import 'package:yaka2/app/modules/user_profil/views/user_profil_view.dart';

import '../controllers/home_controller.dart';
import 'banners_view.dart';
import 'category_view.dart';
import 'listview_collars_view.dart';
import 'listview_machines_view.dart';

class HomeView extends GetView<HomeController> {
  final UserProfilController userProfilController = Get.put(UserProfilController());

  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(),
      drawer: drawer(),
      body: ListView(
        children: [
          BannersView(),
          CategoryView(),
          ListviewCollarsView(),
          // ListviewClothesView(),
          ListviewMachinesView(),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 4,
      centerTitle: true,
      title: const Text(
        'Yaka',
        style: TextStyle(fontFamily: normProBold),
      ),
      actions: [
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 6),
                child: Icon(IconlyLight.wallet),
              ),
              Text(
                '0',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: normsProMedium,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 6, top: 4),
                child: Text(
                  ' TMT',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: normsProMedium,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Drawer drawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          const DrawerHeader(
            child: FlutterLogo(
              size: 150,
            ),
          ),
          ProfilButton(
            name: 'home',
            onTap: () {
              Get.to(() => HomeView());
            },
            icon: IconlyBold.home,
            langIconStatus: false,
          ),
          ProfilButton(
            name: 'favorites',
            onTap: () {
              Get.to(() => const FavoritesView());
            },
            icon: IconlyBold.heart,
            langIconStatus: false,
          ),
          ProfilButton(
            name: 'downloaded',
            onTap: () {
              Get.to(() => const DownloadedView());
            },
            icon: IconlyBold.download,
            langIconStatus: false,
          ),
          ProfilButton(
            name: 'profil',
            onTap: () {
              Get.to(() => UserProfilView());
            },
            icon: IconlyBold.profile,
            langIconStatus: false,
          ),
          userProfilController.userLogin.value
              ? const SizedBox.shrink()
              : ProfilButton(
                  name: 'signUp',
                  onTap: () {
                    Get.to(() => TabbarView());
                  },
                  icon: IconlyBold.login,
                  langIconStatus: false,
                ),
        ],
      ),
    );
  }
}
