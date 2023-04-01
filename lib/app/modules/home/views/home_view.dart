import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:new_version/new_version.dart';
import 'package:open_file_manager/open_file_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/services/auth_service.dart';
import 'package:yaka2/app/data/services/banner_service.dart';
import 'package:yaka2/app/data/services/category_service.dart';
import 'package:yaka2/app/modules/auth/sign_in_page/views/tabbar_view.dart';
import 'package:yaka2/app/modules/cart/controllers/cart_controller.dart';
import 'package:yaka2/app/modules/cart/views/cart_view.dart';
import 'package:yaka2/app/modules/favorites/views/favorites_view.dart';
import 'package:yaka2/app/modules/home/views/instruction_page.dart';
import 'package:yaka2/app/modules/user_profil/controllers/user_profil_controller.dart';
import 'package:yaka2/app/modules/user_profil/views/addMoneyPage.dart';
import 'package:yaka2/app/modules/user_profil/views/downloaded_view.dart';
import 'package:yaka2/app/modules/user_profil/views/user_profil_view.dart';
import 'package:yaka2/app/others/buttons/profile_button.dart';

import '../../user_profil/views/history_order.dart';
import '../controllers/home_controller.dart';
import 'banners_view.dart';
import 'category_view.dart';
import 'package:badges/badges.dart' as badges;

import 'listview_clothes_view.dart';
import 'listview_collars_view.dart';
import 'listview_goods.dart';
import 'listview_machines_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final UserProfilController userProfilController = Get.put(UserProfilController());
  final HomeController homeController = Get.put(HomeController());
  final CartController cartController = Get.put(CartController());

  final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      homeController.getAllProducts();
      appVersionCheck(newVersion);
    });
    cartController.returnCartList();
    homeController.userMoney();
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
    await BannerService().getBanners();
    await CategoryService().getCategories();
    homeController.getAllProducts();
    homeController.userMoney();
    setState(() {});
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  final newVersion = NewVersion(
    iOSId: 'com.bilermennesil.yaka',
    androidId: 'com.bilermennesil.yaka',
  );

  appVersionCheck(NewVersion newVersion) async {
    try {
      final status = await newVersion.getVersionStatus();
      if (status != null) {
        if (status.canUpdate) {
          newVersion.showUpdateDialog(
            context: context,
            versionStatus: status,
            dismissButtonText: 'noUpdate'.tr,
            dialogTitle: 'newVersion'.tr,
            dialogText: 'newVersionTitle'.tr,
            dismissAction: () {
              Navigator.of(context).pop();
            },
            updateButtonText: 'yesUpdate'.tr,
          );
        }
      }
    } on SocketException {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      drawer: _drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const InstructionPage());
        },
        backgroundColor: kPrimaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: borderRadius30,
        ),
        child: const Icon(
          Icons.question_mark_outlined,
          color: Colors.white,
        ),
      ),
      body: SmartRefresher(
        footer: footer(),
        controller: refreshController,
        onRefresh: _onRefresh,
        enablePullDown: true,
        enablePullUp: false,
        physics: const BouncingScrollPhysics(),
        header: const MaterialClassicHeader(
          color: kPrimaryColor,
        ),
        child: ListView(
          children: [
            BannersView(),
            CategoryView(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListviewCollarsView(),
            ),
            ListviewClothesView(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListViewGoods(),
            ),
            ListviewMachinesView(),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
      centerTitle: true,
      title: Image.asset(
        logo1,
        width: 80,
        height: 80,
      ),
      leading: Obx(() {
        return IconButton(
          icon: cartController.list.isNotEmpty
              ? badges.Badge(
                  padding: const EdgeInsets.all(6),
                  animationType: BadgeAnimationType.fade,
                  badgeContent: Text(
                    Get.find<CartController>().list.length.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  child: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                )
              : const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        );
      }),
      actions: [
        GestureDetector(
          onTap: () {
            Get.to(() => const AddCash());
          },
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 6),
                  child: Icon(IconlyLight.wallet),
                ),
                Obx(() {
                  return Text(
                    '${homeController.balance}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: normsProMedium,
                    ),
                  );
                }),
                const Padding(
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
          ),
        )
      ],
    );
  }

  Drawer _drawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          DrawerHeader(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Image.asset(
                logo1,
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
          ),
          ProfilButton(
            name: 'home',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HomeView();
                  },
                ),
              );
              Get.to(() => const HomeView());
            },
            icon: IconlyBold.home,
            langIconStatus: false,
          ),
          ProfilButton(
            name: 'favorites',
            onTap: () {
              Get.to(() => FavoritesView());
            },
            icon: IconlyBold.heart,
            langIconStatus: false,
          ),
          Obx(() {
            return ListTile(
              onTap: () {
                Get.to(() => CartView());
              },
              // tileColor: Colors.white,
              minVerticalPadding: 23,
              title: Text(
                'cart'.tr,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  color: kBlackColor,
                ),
              ),
              leading: cartController.list.isNotEmpty
                  ? badges.Badge(
                      animationType: BadgeAnimationType.fade,
                      padding: const EdgeInsets.all(6),
                      badgeContent: Text(
                        Get.find<CartController>().list.length.toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: kPrimaryColor.withOpacity(0.8), borderRadius: borderRadius15),
                        child: const Icon(
                          IconlyBold.bag2,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: kPrimaryColor.withOpacity(0.8), borderRadius: borderRadius15),
                      child: const Icon(
                        IconlyBold.bag2,
                        color: Colors.white,
                      ),
                    ),
              trailing: const Icon(
                IconlyLight.arrowRightCircle,
                color: kPrimaryColor,
              ),
            );
          }),
          ProfilButton(
            name: 'downloaded',
            onTap: () async {
              final token = await Auth().getToken();
              if (token == null) {
                showSnackBar('loginError', 'loginError1', Colors.red);
                await Get.to(() => const TabbarView());
              } else {
                await Get.to(() => const DownloadedView());
              }
            },
            icon: IconlyBold.download,
            langIconStatus: false,
          ),
          userProfilController.userLogin.value
              ? ProfilButton(
                  name: 'orders',
                  onTap: () {
                    Get.to(() => const HistoryOrders());
                  },
                  icon: CupertinoIcons.cube_box_fill,
                  langIconStatus: false,
                )
              : const SizedBox.shrink(),
          Padding(
            // color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Divider(
              color: kPrimaryColor.withOpacity(0.4),
              thickness: 2,
            ),
          ),
          ProfilButton(
            name: 'transferUSB',
            onTap: () async {
              await openFileManager().then((value) {});
            },
            icon: Icons.usb,
            langIconStatus: true,
            langIcon: customIcon(
              'assets/icons/usb5.png',
            ),
          ),
          ProfilButton(
            name: 'addMoney',
            onTap: () {
              Get.to(() => const AddCash());
            },
            icon: IconlyBold.wallet,
            langIconStatus: false,
          ),
          ProfilButton(
            name: 'settings',
            onTap: () {
              Get.to(() => const UserProfilView());
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
                      Get.to(() => const TabbarView());
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
