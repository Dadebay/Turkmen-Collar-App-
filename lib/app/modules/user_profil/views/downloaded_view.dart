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

class DownloadedView extends GetView {
  const DownloadedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      appBar: AppBar(
        title: Text(
          'downloaded'.tr,
          style: TextStyle(fontFamily: normProBold, color: Colors.black),
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
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
              decoration: BoxDecoration(
                borderRadius: borderRadius15,
                color: kPrimaryColorCard,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      fadeInCurve: Curves.ease,
                      imageUrl: snapshot.data![index].images![0],
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
                  Padding(
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
                          child: Text(
                            snapshot.data![index].name!,
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: normsProRegular),
                          ),
                        ),
                        Text(
                          snapshot.data![index].machineName ?? '',
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.grey, fontSize: 16, fontFamily: normsProRegular),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final token = await Auth().getToken();
                      if (token == null) {
                        showSnackBar('loginError', 'loginErrorSubtitle1', Colors.red);
                      } else {
                        // snapshot.data![index].file!.length == 0
                        //     ? showSnackBar('errorTitle', 'noFile', Colors.red)
                        //     : Get.to(
                        //         () => DownloadYakaPage(
                        //           image: snapshot.data![index].images![0],
                        //           // list: snapshot.data![index].file!,
                        //           pageName: snapshot.data![index].name!,
                        //         ),
                        //       );
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      width: Get.size.width,
                      padding: EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
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
                  ),
                ],
              ),
            ),
            staggeredTileBuilder: (index) => const StaggeredTile.count(1, 1.5),
          );
        },
      ),
    );
  }
}
