import 'dart:io';
import 'dart:math';

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
import 'package:yaka2/app/data/services/collars_service.dart';
import 'package:yaka2/app/data/services/file_download_service.dart';
import 'package:yaka2/app/others/product_profil/views/photo_view.dart';

import '../../../modules/home/controllers/home_controller.dart';

class DownloadYakaPage extends StatefulWidget {
  DownloadYakaPage({Key? key, required this.image, required this.list, required this.pageName, required this.id}) : super(key: key);
  final int id;
  final String image;
  final List<FilesModel> list;
  final String pageName;

  @override
  State<DownloadYakaPage> createState() => _DownloadYakaPageState();
}

class _DownloadYakaPageState extends State<DownloadYakaPage> {
  final HomeController homeController = Get.put(HomeController());
  bool wait = false;
  bool purchased = false;
  List<FilesModel> list = [];

  @override
  void initState() {
    super.initState();
    list = widget.list;
    createDownloadFile();
  }

  dynamic createDownloadFile() async {
    final path1 = Directory('storage/emulated/0/Download');
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    } else if (status.isDenied) {
      await Permission.storage.request();
    }
    if (await path1.exists()) {
      await createFolder();
      return path1.path;
    } else {
      await createFolder();
      await path1.create();
      return path1.path;
    }
  }

  Future<String> createFolder() async {
    final path = Directory('storage/emulated/0/Download/YAKA');

    if (await path.exists()) {
      await createFolder2();
      return path.path;
    } else {
      await path.create();
      await createFolder2();
      return path.path;
    }
  }

  Future<String> createFolder2() async {
    final path1 = Directory('storage/emulated/0/Download/YAKA/EMB');
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (await path1.exists()) {
      await createFolder3();
      return path1.path;
    } else {
      await createFolder3();
      await path1.create();
      return path1.path;
    }
  }

  Future<String> createFolder4() async {
    final path1 = Directory('storage/emulated/0/Download/YAKA/brother');
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (await path1.exists()) {
      return path1.path;
    } else {
      await path1.create();
      return path1.path;
    }
  }

  Future<String> createFolder3() async {
    final path1 = Directory('storage/emulated/0/Download/YAKA/EmbF5');
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (await path1.exists()) {
      await createFolder4();
      return path1.path;
    } else {
      await path1.create();
      await createFolder4();

      return path1.path;
    }
  }

  Future<String> createFolderProductName(String name) async {
    final path1 = Directory('storage/emulated/0/Download/YAKA/$name/${widget.pageName}');
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (await path1.exists()) {
      return path1.path;
    } else {
      await path1.create();
      return path1.path;
    }
  }

  AppBar appbar() {
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
                final double a = double.parse(homeController.balance.toString());
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
        widget.pageName.tr,
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

  dynamic findName(int index) {
    String name = '';

    if (list[index].machineName == 'brother') {
      name = 'brother';
    } else if (list[index].machineName! == '450 E' || list[index].machineName! == '4 iňňe' || list[index].machineName! == '200 - 230') {
      name = 'EMB';
    } else {
      name = 'EmbF5';
    }
    return name;
  }

  dynamic checkStatus() async {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    } else if (status.isDenied) {
      await Permission.storage.request();
    }
  }

  dynamic findFileFormat(String text) {
    String aa = '';
    for (int i = text.length - 1; i > 0; i--) {
      aa += text[i];
      if (text[i] == '.') break;
    }
    return aa.split('').reversed.join();
  }

  dynamic findFileName(String text) {
    String bb = '';
    String cc = '';
    for (int i = text.length - 1; i > 0; i--) {
      if (text[i] == '/') break;
      bb += text[i];
    }
    for (int i = bb.length - 1; i > 0; i--) {
      if (bb[i] == '.') break;
      cc += bb[i];
    }
    return cc;
  }

  dynamic downloadYaka(int index) async {
    final double balance = double.parse(homeController.balance.toString().substring(0, homeController.balance.toString().length - 2));
    final Dio dio = Dio();
    final Random rand = Random();
    final String name = findName(index);
    List<dynamic> downloadFileList = [];
    final int b = 0;

    checkStatus();
    if (list[index].purchased == false) {
      if (balance >= list[index].price! / 100) {
        wait = true;
        setState(() {});
        await FileDownloadService().downloadFile(id: list[index].id!).then(
          (value) async {
            downloadFileList = value;
            await createFolder();
            await createFolder2();
            await createFolder3();
            await createFolder4();
            await createFolderProductName(name);

            ///
            for (int i = 0; i < downloadFileList.length; i++) {
              final String fileFormat = findFileFormat(downloadFileList[i]);
              final String fileName = findFileName(downloadFileList[i]);
              await dio.download(downloadFileList[i], 'storage/emulated/0/Download/YAKA/$name/${widget.pageName}/' + '$fileName' + '  -$i-' + '${fileFormat}').then((value) async {
                if (i == downloadFileList.length - 1) {
                  wait = false;
                  await CollarService().getCollarsByID(widget.id).then((value) {
                    list = value.files!;
                  });
                  await CollarService().getCollars();
                  setState(() {
                    showSnackBar('downloadTitle', 'downloadSubtitle', kPrimaryColor);
                  });
                }
              });
            }

            ///
          },
        );
        homeController.userMoney();
      } else {
        showSnackBar('noMoney', 'noMoneySubtitle', Colors.red);
      }
    } else {
      //yakany satyn alan bolsa Pula Seretmeli dal skacat etmeli goni
      wait = true;
      setState(() {});
      await FileDownloadService().downloadFile(id: list[index].id!).then(
        (value) async {
          downloadFileList = value;
          await createFolder();
          await createFolder2();
          await createFolder3();
          await createFolder4();
          await createFolderProductName(name);

          ///
          for (int i = 0; i < downloadFileList.length; i++) {
            final String fileFormat = findFileFormat(downloadFileList[i]);
            final String fileName = findFileName(downloadFileList[i]);
            await dio.download(downloadFileList[i], 'storage/emulated/0/Download/YAKA/$name/${widget.pageName}/' + '$fileName' + '  -$i-' + '${fileFormat}').then((value) {
              if (i == downloadFileList.length - 1) {
                wait = false;
                setState(() {
                  showSnackBar('downloadTitle', 'downloadSubtitle', kPrimaryColor);
                });
              }
            });
          }

          ///
        },
      );
      homeController.userMoney();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: Get.size.height / 2.5,
                margin: EdgeInsets.all(15),
                child: GestureDetector(
                  onTap: () async {
                    await Get.to(() => PhotoViewPage(
                          image: widget.image,
                          networkImage: true,
                        ));
                  },
                  child: ClipRRect(
                    borderRadius: borderRadius10,
                    child: CachedNetworkImage(
                      fadeInCurve: Curves.ease,
                      imageUrl: widget.image,
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
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: list.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    purchased = list[index].purchased!;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: borderRadius10,
                              color: Colors.grey.withOpacity(
                                0.2,
                              ),
                            ),
                            child: CachedNetworkImage(
                              fadeInCurve: Curves.ease,
                              imageUrl: list[index].machineImage![0],
                              imageBuilder: (context, imageProvider) => Container(
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: borderRadius5,
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
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10, left: 6),
                            child: Text(
                              list[index].machineName ?? 'Yaka',
                              style: TextStyle(
                                color: purchased ? Colors.green.withOpacity(0.6) : Colors.black,
                                fontFamily: normsProMedium,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${list[index].price! / 100}',
                                style: TextStyle(
                                  color: purchased ? Colors.green.withOpacity(0.6) : Colors.red,
                                  fontSize: 20,
                                  fontFamily: normProBold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: Text(
                                  ' TMT',
                                  style: TextStyle(
                                    color: purchased ? Colors.green.withOpacity(0.6) : Colors.red,
                                    fontSize: 11,
                                    fontFamily: normsProMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: purchased ? 2 : 2,
                          child: GestureDetector(
                            onTap: () {
                              askToDownloadYaka(index);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 8, left: 8),
                              padding: EdgeInsets.all(8),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: purchased ? Colors.green.withOpacity(0.4) : kPrimaryColor, borderRadius: borderRadius10),
                              child: purchased
                                  ? Text(
                                      'downloadedYAKA'.tr,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : Text(
                                      'download'.tr,
                                      textAlign: TextAlign.center,
                                    ),
                            ),
                          ),
                        )
                      ],
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
          wait
              ? Container(
                  width: Get.size.width,
                  height: Get.size.height,
                  color: Colors.grey.withOpacity(0.6),
                )
              : SizedBox.shrink(),
          wait
              ? Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: borderRadius20,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'downloadedYakalar'.tr,
                            textAlign: TextAlign.center,
                            maxLines: 4,
                            style: TextStyle(color: Colors.black, fontFamily: normsProMedium, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Future<dynamic> askToDownloadYaka(int index) {
    return Get.defaultDialog(
      title: 'Üns ber',
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      titlePadding: EdgeInsets.only(top: 15),
      titleStyle: TextStyle(color: Colors.black, fontFamily: normProBold, fontSize: 22),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              'wantToBuyCollar'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      downloadYaka(index);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: borderRadius10),
                      padding: EdgeInsets.all(10),
                    ),
                    child: Text(
                      'agree'.tr,
                      style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: normProBold),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey.withOpacity(0.6),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: borderRadius10),
                      padding: EdgeInsets.all(10),
                    ),
                    child: Text(
                      'no'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
