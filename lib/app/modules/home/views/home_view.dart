import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/modules/auth/sign_in_page/views/tabbar_view.dart';
import 'package:yaka2/app/modules/cart/views/cart_view.dart';
import 'package:yaka2/app/modules/favorites/views/favorites_view.dart';
import 'package:yaka2/app/modules/user_profil/controllers/user_profil_controller.dart';
import 'package:yaka2/app/modules/user_profil/views/downloaded_view.dart';
import 'package:yaka2/app/modules/user_profil/views/user_profil_view.dart';
import 'package:yaka2/app/others/buttons/profile_button.dart';

import '../controllers/home_controller.dart';
import 'listview_collars_view.dart';

class HomeView extends GetView<HomeController> {
  final UserProfilController userProfilController = Get.put(UserProfilController());
  final HomeController homeController = Get.put(HomeController());
  var scaffoldKey = GlobalKey<ScaffoldState>();
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: appBar(context),
      drawer: drawer(),
      body: ListView(
        children: [
          // BannersView(),
          // CategoryView(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ListviewCollarsView(),
          ),
          // ListviewClothesView(),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 20),
          //   child: ListviewMachinesView(),
          // ),
          // const SizedBox(
          //   height: 40,
          // )
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
      centerTitle: true,
      title: const Text(
        'Yaka',
        style: TextStyle(fontFamily: normProBold, color: Colors.black),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      actions: [
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 6),
                child: Icon(IconlyLight.wallet),
              ),
              Obx(() {
                return Text(
                  '${homeController.balance}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: normsProMedium,
                  ),
                );
              }),
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
          DrawerHeader(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Image.asset(
                logo,
                fit: BoxFit.cover,
                height: 200,
              ),
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
            name: 'cart',
            onTap: () {
              Get.to(() => CartView());
            },
            icon: IconlyBold.bag2,
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
          Obx(() {
            return userProfilController.userLogin.value
                ? const SizedBox.shrink()
                : ProfilButton(
                    name: 'signUp',
                    onTap: () {
                      Get.to(() => TabbarView());
                    },
                    icon: IconlyBold.login,
                    langIconStatus: false,
                  );
          }),
        ],
      ),
    );
  }
}
