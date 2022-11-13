import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:restart_app/restart_app.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/modules/user_profil/controllers/user_profil_controller.dart';

dynamic noBannerImage() {
  return const Text('No Image');
}

dynamic spinKit() {
  return CircularProgressIndicator(
    color: kPrimaryColor,
  );
}

SnackbarController showSnackBar(String title, String subtitle, Color color) {
  return Get.snackbar(
    title,
    subtitle,
    snackStyle: SnackStyle.FLOATING,
    titleText: title == ''
        ? const SizedBox.shrink()
        : Text(
            title.tr,
            style: const TextStyle(fontFamily: normsProMedium, fontSize: 18, color: Colors.white),
          ),
    messageText: Text(
      subtitle.tr,
      style: const TextStyle(fontFamily: normsProRegular, fontSize: 16, color: Colors.white),
    ),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: color,
    borderRadius: 20.0,
    animationDuration: const Duration(milliseconds: 800),
    margin: const EdgeInsets.all(8),
  );
}

Container divider() {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Divider(
      color: kPrimaryColor.withOpacity(0.4),
      thickness: 2,
    ),
  );
}

Padding namePart({required String text, required bool removeIcon, required Function() onTap}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text.tr, style: const TextStyle(color: Colors.black, fontFamily: normsProRegular, fontSize: 22)),
        removeIcon
            ? SizedBox.shrink()
            : IconButton(
                onPressed: onTap,
                icon: const Icon(
                  IconlyLight.arrowRightCircle,
                  color: kPrimaryColor,
                  size: 25,
                ),
              )
      ],
    ),
  );
}

void changeLanguage() {
  final UserProfilController userProfilController = Get.put(UserProfilController());

  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(color: Colors.white),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                Text(
                  'select_language'.tr,
                  style: const TextStyle(color: Colors.black, fontFamily: normProBold, fontSize: 18),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(CupertinoIcons.xmark_circle, size: 22, color: Colors.black),
                )
              ],
            ),
          ),
          divider(),
          ListTile(
            onTap: () {
              userProfilController.switchLang('tr');
              Get.back();
            },
            leading: const CircleAvatar(
              backgroundImage: AssetImage(
                tmIcon,
              ),
              backgroundColor: Colors.black,
              radius: 20,
            ),
            title: const Text(
              'Türkmen',
              style: TextStyle(color: Colors.black),
            ),
          ),
          divider(),
          ListTile(
            onTap: () {
              userProfilController.switchLang('ru');
              Get.back();
            },
            leading: const CircleAvatar(
              backgroundImage: AssetImage(
                ruIcon,
              ),
              radius: 20,
              backgroundColor: Colors.black,
            ),
            title: const Text(
              'Русский',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    ),
  );
}

void logOut() {
  Get.bottomSheet(
    Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                Text(
                  'log_out'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(CupertinoIcons.xmark_circle, size: 22, color: Colors.white),
                )
              ],
            ),
          ),
          divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Text(
              'log_out_title'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[500],
                fontFamily: normsProMedium,
                fontSize: 16,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              // await Auth().logout();
              Get.back();
              await Restart.restartApp();
            },
            child: Container(
              width: Get.size.width,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.grey[500], borderRadius: borderRadius10),
              child: Text(
                'yes'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              Get.back();
            },
            child: Container(
              width: Get.size.width,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: Colors.red, borderRadius: borderRadius10),
              child: Text(
                'no'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

CustomFooter footer() {
  return CustomFooter(
    builder: (BuildContext context, LoadStatus? mode) {
      Widget body;
      if (mode == LoadStatus.idle) {
        body = const Text('');
      } else if (mode == LoadStatus.loading) {
        body = const CircularProgressIndicator(
          color: kPrimaryColor,
        );
      } else if (mode == LoadStatus.failed) {
        body = const Text('Load Failed!Click retry!');
      } else if (mode == LoadStatus.canLoading) {
        body = const Text('');
      } else {
        body = const Text('No more Data');
      }
      return SizedBox(
        height: 55.0,
        child: Center(child: body),
      );
    },
  );
}

Padding textpart(String name, bool value) {
  return Padding(
    padding: EdgeInsets.only(left: 8, top: value ? 15 : 30),
    child: Text(
      name.tr,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(fontSize: 18, color: Colors.black, fontFamily: normsProMedium),
    ),
  );
}

void defaultBottomSheet({required String name, required Widget child}) {
  Get.bottomSheet(
    Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                Text(
                  name.tr,
                  style: const TextStyle(color: Colors.black, fontFamily: normProBold, fontSize: 18),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(CupertinoIcons.xmark_circle, size: 22, color: Colors.black),
                )
              ],
            ),
          ),
          const Divider(
            color: kBlackColor,
            thickness: 1,
          ),
          Center(
            child: child,
          )
        ],
      ),
    ),
  );
}

dynamic errorPage({required Function() onTap}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'noConnection2'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontFamily: normsProRegular, fontSize: 18),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: borderRadius10),
            primary: kPrimaryColor,
          ),
          child: Text(
            'noConnection3'.tr,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      )
    ],
  );
}

dynamic emptyPageImage({required Function() onTap}) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(noData, width: 350, height: 350),
        Text(
          'noData'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontFamily: normsProRegular, fontSize: 18),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: borderRadius10),
              primary: kPrimaryColor,
            ),
            child: Text(
              'noConnection3'.tr,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        )
      ],
    ),
  );
}

dynamic emptryPageText() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'noData1'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontFamily: normsProRegular, fontSize: 18),
      ),
    ),
  );
}

Expanded emptyCart() {
  return Expanded(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/emptyCART.json', width: 350, height: 350),
            Text(
              'cartEmpty'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontFamily: normProBold, fontSize: 20),
            ),
            Text(
              'cartEmptySubtitle'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontFamily: normsProRegular, fontSize: 20),
            ),
          ],
        ),
      ),
    ),
  );
}
