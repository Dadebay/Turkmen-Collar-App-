import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/services/auth_service.dart';
import 'package:yaka2/app/data/services/banner_service.dart';
import 'package:yaka2/app/data/services/category_service.dart';
import 'package:yaka2/app/data/services/collars_service.dart';
import 'package:yaka2/app/data/services/dresses_service.dart';
import 'package:yaka2/app/data/services/machines_service.dart';
import 'package:yaka2/app/modules/auth/sign_in_page/views/tabbar_view.dart';
import 'package:yaka2/app/modules/cart/controllers/cart_controller.dart';
import 'package:yaka2/app/modules/cart/views/cart_view.dart';
import 'package:yaka2/app/modules/favorites/views/favorites_view.dart';
import 'package:yaka2/app/modules/home/views/instruction_page.dart';
import 'package:yaka2/app/modules/home/views/listview_clothes_view.dart';
import 'package:yaka2/app/modules/home/views/listview_machines_view.dart';
import 'package:yaka2/app/modules/user_profil/controllers/user_profil_controller.dart';
import 'package:yaka2/app/modules/user_profil/views/addMoneyPage.dart';
import 'package:yaka2/app/modules/user_profil/views/downloaded_view.dart';
import 'package:yaka2/app/modules/user_profil/views/user_profil_view.dart';
import 'package:yaka2/app/others/buttons/profile_button.dart';

import '../controllers/home_controller.dart';
import 'banners_view.dart';
import 'category_view.dart';
import 'listview_collars_view.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final UserProfilController userProfilController = Get.put(UserProfilController());

  final HomeController homeController = Get.put(HomeController());

  final CartController cartController = Get.put(CartController());

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
    await BannerService().getBanners();
    await CategoryService().getCategories();
    await CollarService().getCollars();
    await DressesService().getDresses();
    await MachineService().getMachines();
    await CategoryService().getCategories();
    homeController.userMoney();
    setState(() {});
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      resizeToAvoidBottomInset: false,
      appBar: appBar(context),
      drawer: drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(() => InstructionPage());
          print('a');
          showSnackBar('ASd', 'Asd', Colors.red);
        },
        backgroundColor: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius30,
        ),
        child: Icon(
          Icons.question_mark_outlined,
          color: Colors.white,
        ),
      ),
      body: SmartRefresher(
        footer: footer(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        enablePullDown: true,
        enablePullUp: true,
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
              child: ListviewMachinesView(),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
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
          icon: cartController.list.length >= 1
              ? Badge(
                  padding: EdgeInsets.all(6),
                  animationType: BadgeAnimationType.fade,
                  badgeContent: Text(
                    Get.find<CartController>().list.length.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  child: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                )
              : Icon(
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
            Get.to(() => AddCash());
          },
          child: Center(
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
                logo1,
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
              tileColor: Colors.white,
              minVerticalPadding: 23,
              title: Text(
                'cart'.tr,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  color: kBlackColor,
                ),
              ),
              leading: cartController.list.length >= 1
                  ? Badge(
                      animationType: BadgeAnimationType.fade,
                      padding: EdgeInsets.all(6),
                      badgeContent: Text(
                        Get.find<CartController>().list.length.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: kPrimaryColor.withOpacity(0.8), borderRadius: borderRadius15),
                        child: Icon(
                          IconlyBold.bag2,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: kPrimaryColor.withOpacity(0.8), borderRadius: borderRadius15),
                      child: Icon(
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
              } else {
                await Get.to(() => const DownloadedView());
              }
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
