import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/collar_model.dart';
import 'package:yaka2/app/data/services/file_download.dart';

import '../../../modules/home/controllers/home_controller.dart';

class DownloadYakaPage extends StatelessWidget {
  DownloadYakaPage({Key? key, required this.image, required this.list, required this.pageName}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());
  final String image;
  final List<FilesModel> list;
  final String pageName;

  Future<String> createFolder() async {
    final path = Directory('storage/emulated/0/Download/YAKA');
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (await path.exists()) {
      return path.path;
    } else {
      await path.create();
      return path.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Column(
        children: [
          Container(
            height: 300,
            margin: EdgeInsets.all(15),
            child: ClipRRect(
              borderRadius: borderRadius10,
              child: CachedNetworkImage(
                fadeInCurve: Curves.ease,
                imageUrl: image,
                imageBuilder: (context, imageProvider) => Container(
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
          ),
          Expanded(
            child: ListView.separated(
              itemCount: list.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    final int b = int.parse(homeController.balance.toString().substring(0, homeController.balance.toString().length - 2));
                    final status = await Permission.storage.status;
                    if (!status.isGranted) {
                      await Permission.storage.request();
                    }
                    if (b >= list[index].price! / 100) {
                      await createFolder();
                      await FileDownload().downloadFile(id: list[index].id!).then(
                        (value) async {
                          final Dio dio = Dio();
                          await dio.download(value, 'storage/emulated/0/Download' + '/${list[index].name}.jef').then((value) {
                            print(value);
                            showSnackBar('Skacat etdi', 'oh yesss', kPrimaryColor);
                          });
                        },
                      );
                      // homeController.userMoney();
                    } else {
                      showSnackBar('noMoney', 'noMoneySubtitle', Colors.red);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(list[index].name!),
                      ),
                      Text(
                        list[index].machineName ?? 'asd',
                        style: TextStyle(color: Colors.red, fontFamily: normProBold, fontSize: 18),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${list[index].price! / 100}',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontFamily: normProBold,
                                ),
                              ),
                              Padding(
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
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(IconlyLight.download),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 1,
                  color: Colors.black,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  AppBar appbar() {
    double a = double.parse(homeController.balance.toString());
    a = a / 100;
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarIconBrightness: Brightness.dark),
      centerTitle: true,
      actions: [
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() {
                return Text(
                  '$a',
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
      title: Text(
        pageName.tr,
        style: TextStyle(fontFamily: normProBold, color: Colors.black),
      ),
      leading: IconButton(
        icon: const Icon(
          IconlyLight.arrowLeftCircle,
          color: Colors.black,
        ),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}
