import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/auth_model.dart';
import 'package:yaka2/app/data/models/donwloads_model.dart';
import 'package:yaka2/app/data/services/downloads_service.dart';
import 'package:yaka2/app/modules/auth/sign_in_page/views/tabbar_view.dart';
import 'package:yaka2/app/others/product_profil/views/download_yaka.dart';

class DownloadedView extends GetView {
  const DownloadedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      appBar: AppBar(
        title: Text(
          'downloaded'.tr,
          style: const TextStyle(fontFamily: normProBold, color: Colors.black),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            IconlyLight.arrowLeftCircle,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarIconBrightness: Brightness.dark),
        centerTitle: true,
      ),
      body: FutureBuilder<List<DownloadsModel>>(
        future: DownloadsService().getDownloadedProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: spinKit(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: errorPage(
                onTap: () {
                  DownloadsService().getDownloadedProducts();
                },
              ),
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: emptyPageImage(
                onTap: () {
                  DownloadsService().getDownloadedProducts();
                },
              ),
            );
          }

          return StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final double a = double.parse(snapshot.data![index].price!.toString());
              final double b = a / 100.0;
              return Container(
                margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                decoration: const BoxDecoration(
                  borderRadius: borderRadius15,
                  color: kPrimaryColorCard,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CachedNetworkImage(  memCacheWidth: 10,
                 memCacheHeight: 10,
                        fadeInCurve: Curves.ease,
                        imageUrl: snapshot.data![index].images!.first,
                        imageBuilder: (context, imageProvider) => Container(
                          margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                          decoration: BoxDecoration(
                            borderRadius: borderRadius10,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(child: spinKit()),
                        errorWidget: (context, url, error) => noBannerImage(),
                      ),
                    ),
                    namePart(snapshot, index, b),
                    downloadButton(snapshot, index),
                  ],
                ),
              );
            },
            staggeredTileBuilder: (index) => const StaggeredTile.count(1, 1.5),
          );
        },
      ),
    );
  }

  Padding namePart(AsyncSnapshot<List<DownloadsModel>> snapshot, int index, double b) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        bottom: 5,
        right: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              snapshot.data![index].name!,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  b.toStringAsFixed(b > 1000 ? 0 : 2),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 19,
                    fontFamily: normProBold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    ' TMT',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 11,
                      fontFamily: normsProMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector downloadButton(AsyncSnapshot<List<DownloadsModel>> snapshot, int index) {
    return GestureDetector(
      onTap: () async {
        final token = await Auth().getToken();
        if (token == null) {
          showSnackBar('loginError', 'loginErrorSubtitle1', Colors.red);
          await Get.to(() => const TabbarView());
        } else {
          snapshot.data![index].files!.isEmpty
              ? showSnackBar('errorTitle', 'noFile', Colors.red)
              : Get.to(
                  () => DownloadYakaPage(
                    image: snapshot.data![index].images!.first,
                    list: snapshot.data![index].files!,
                    pageName: snapshot.data![index].name!,
                    id: snapshot.data![index].id!,
                  ),
                );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        width: Get.size.width,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
          borderRadius: borderRadius10,
        ),
        alignment: Alignment.center,
        child: Text('download'.tr),
      ),
    );
  }
}
