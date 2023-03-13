import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/error_state/no_image.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/collar_model.dart';
import 'package:yaka2/app/data/services/collars_service.dart';
import 'package:yaka2/app/data/services/file_download_service.dart';
import 'package:yaka2/app/others/product_profil/controllers/product_profil_controller.dart';
import 'package:yaka2/app/others/product_profil/views/photo_view.dart';

import '../../../constants/loadings/loading.dart';
import '../../../modules/home/controllers/home_controller.dart';

class DownloadYakaPage extends StatefulWidget {
  final int id;
  final String image;
  final String pageName;
  const DownloadYakaPage({
    required this.image,
    required this.pageName,
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<DownloadYakaPage> createState() => _DownloadYakaPageState();
}

class _DownloadYakaPageState extends State<DownloadYakaPage> {
  final HomeController homeController = Get.put(HomeController());
  final ProductProfilController productProfilController = Get.put(ProductProfilController());
  bool wait = false;

  List<FilesModel> list = [];

  @override
  void initState() {
    super.initState();
    CollarService().getCollarsByID(widget.id).then(
      (value) {
        list = value.files!;
        setState(() {});
      },
    );
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
      return path.path;
    } else {
      await path.create();
      return path.path;
    }
  }

  dynamic createFolderMachineNames(String name) async {
    if (name == 'JANOME MB4-MB4S') {
      final path1 = Directory('storage/emulated/0/Download/YAKA/JANOME MB4-MB4S');
      if (path1.existsSync()) {
        return path1.path;
      } else {
        await path1.create(recursive: true);
        final path2 = Directory('storage/emulated/0/Download/YAKA/JANOME MB4-MB4S/Emb');
        await path2.create();
        return path1.path;
      }
    } else if (name == 'JANOME 450E-500E') {
      final path3 = Directory('storage/emulated/0/Download/YAKA/JANOME 450E-500E');
      if (path3.existsSync()) {
        return path3.path;
      } else {
        await path3.create(recursive: true);
        final path4 = Directory('storage/emulated/0/Download/YAKA/JANOME 450E-500E/Emb');
        await path4.create();
        return path3.path;
      }
    } else if (name == 'JANOME 350E-370E') {
      final path3 = Directory('storage/emulated/0/Download/YAKA/JANOME 350E-370E');
      if (path3.existsSync()) {
        return path3.path;
      } else {
        await path3.create(recursive: true);
        final path4 = Directory('storage/emulated/0/Download/YAKA/JANOME 350E-370E/EmbF5');
        await path4.create();
        return path3.path;
      }
    } else if (name == 'JANOME 200E-230E') {
      final path3 = Directory('storage/emulated/0/Download/YAKA/JANOME 200E-230E');
      if (path3.existsSync()) {
        return path3.path;
      } else {
        await path3.create(recursive: true);
        final path4 = Directory('storage/emulated/0/Download/YAKA/JANOME 200E-230E/Emb');
        await path4.create();
        return path3.path;
      }
    } else if (name == 'BERNETTE 340') {
      final path3 = Directory('storage/emulated/0/Download/YAKA/BERNETTE 340');
      if (path3.existsSync()) {
        return path3.path;
      } else {
        await path3.create(recursive: true);
        final path4 = Directory('storage/emulated/0/Download/YAKA/BERNETTE 340/EmbF5');
        await path4.create();
        return path3.path;
      }
    } else if (name == 'BROTHER V3') {
      final path3 = Directory('storage/emulated/0/Download/YAKA/BROTHER V3');
      if (path3.existsSync()) {
        return path3.path;
      } else {
        await path3.create(recursive: true);
        final path4 = Directory('storage/emulated/0/Download/YAKA/BROTHER V3/Emb');
        await path4.create();
        return path3.path;
      }
    }
  }

  Future<String> createFolderProductName(String name) async {
    print(widget.pageName);
    final path1 = Directory('storage/emulated/0/Download/YAKA/$name/${widget.pageName}');
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (path1.existsSync()) {
      return path1.path;
    } else {
      await path1.create(recursive: true);
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
        )
      ],
      title: Text(
        widget.pageName.tr,
        style: const TextStyle(fontFamily: normProBold, color: Colors.black),
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
    if (list[index].machineName!.toUpperCase() == 'BROTHER V3') {
      name = 'Emb';
    } else if (list[index].machineName!.toUpperCase() == 'JANOME 450E-500E' ||
        list[index].machineName!.toUpperCase() == 'JANOME MB4-MB4S' ||
        list[index].machineName!.toUpperCase() == 'JANOME 200E-230E') {
      name = 'Emb';
    } else {
      name = 'EmbF5';
    }
    return '${list[index].machineName!.toUpperCase()}/$name';
  }

  dynamic findFileFormat(String text) {
    String aa = '';
    for (int i = text.length - 1; i > 0; i--) {
      aa += text[i];
      if (text[i] == '.') {
        break;
      }
    }
    return aa.split('').reversed.join();
  }

  dynamic findFileName(String text) {
    String bb = '';
    String cc = '';
    for (int i = text.length - 1; i > 0; i--) {
      if (text[i] == '/') {
        break;
      }
      bb += text[i];
    }
    for (int i = bb.length - 1; i > 0; i--) {
      if (bb[i] == '.') {
        break;
      }
      cc += bb[i];
    }
    return cc;
  }

  dynamic downloadYaka(int index) async {
    productProfilController.sany.value = 0;
    productProfilController.totalSum.value = 0;
    final double balance = double.parse(homeController.balance.toString().substring(0, homeController.balance.toString().length - 2));
    final Dio dio = Dio();
    final Random rand = Random();
    final String name = findName(index);
    List<dynamic> downloadFileList = [];
    if (list[index].purchased == false) {
      if (balance >= list[index].price! / 100) {
        wait = true;
        setState(() {});
        await FileDownloadService().downloadFile(id: list[index].id!).then(
          (value) async {
            downloadFileList = value;
            productProfilController.totalSum.value = downloadFileList.length;
            //Create Yaka folder
            await createFolderMachineNames(list[index].machineName!.toUpperCase());
            await createFolderProductName(name);
            for (int i = 0; i < downloadFileList.length; i++) {
              final int a = rand.nextInt(100);
              final String fileFormat = findFileFormat(downloadFileList[i]);
              final String fileName = findFileName(downloadFileList[i]);
              try {
                await dio.download(
                  downloadFileList[i],
                  'storage/emulated/0/Download/YAKA/$name/${widget.pageName}/$fileName  ($a)$fileFormat',
                  onReceiveProgress: (int count, int total) {
                    if (count == total) {
                      productProfilController.sany.value++;
                    }
                  },
                ).then((value) async {
                  if (i == downloadFileList.length - 1) {
                    wait = false;
                    await CollarService().getCollarsByID(widget.id).then((value) {
                      list = value.files!;
                    });
                    setState(() {
                      showSnackBar('downloadTitle', 'downloadSubtitle', kPrimaryColor);
                    });
                  }
                });
              } catch (e) {
                if (wait) {
                  Future.delayed(const Duration(minutes: 1), () {
                    wait = false;
                    showSnackBar('noConnection3', 'error', kPrimaryColor);
                    setState(() {});
                  });
                }
              }
            }
          },
        );
        homeController.userMoney();
      } else {
        showSnackBar('noMoney', 'noMoneySubtitle', Colors.red);
      }
    } else {
      wait = true;
      setState(() {});
      await FileDownloadService().downloadFile(id: list[index].id!).then(
        (value) async {
          downloadFileList = value;
          productProfilController.totalSum.value = downloadFileList.length;
          await createFolder();
          await createFolderMachineNames(list[index].machineName!.toUpperCase());
          await createFolderProductName(name);
          for (int i = 0; i < downloadFileList.length; i++) {
            final int a = rand.nextInt(100);
            final String fileFormat = findFileFormat(downloadFileList[i]);
            final String fileName = findFileName(downloadFileList[i]);
            try {
              await dio.download(
                downloadFileList[i],
                'storage/emulated/0/Download/YAKA/$name/${widget.pageName}/$fileName  -$a-$fileFormat',
                onReceiveProgress: (int count, int total) {
                  if (count == total) {
                    productProfilController.sany.value++;
                  }
                },
              ).then((value) {
                if (i == downloadFileList.length - 1) {
                  wait = false;
                  setState(() {
                    showSnackBar('downloadTitle', 'downloadSubtitle', kPrimaryColor);
                  });
                }
              });
            } catch (e) {
              if (wait) {
                Future.delayed(const Duration(minutes: 1), () {
                  wait = false;
                  showSnackBar('noConnection3', 'error', kPrimaryColor);
                  setState(() {});
                });
              }
            }
          }
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
          page(),
          wait
              ? Container(
                  width: Get.size.width,
                  height: Get.size.height,
                  color: Colors.grey.withOpacity(0.6),
                )
              : const SizedBox.shrink(),
          wait
              ? Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: borderRadius20,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Obx(
                            () => Text(
                              'downloadedYakalar'.tr + '${productProfilController.sany.value}/${productProfilController.totalSum.value}',
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              style: const TextStyle(color: Colors.black, fontFamily: normsProMedium, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Column page() {
    return Column(
      children: [
        Container(
          height: Get.size.height / 2.5,
          margin: const EdgeInsets.all(15),
          child: GestureDetector(
            onTap: () async {
              await Get.to(
                () => PhotoViewPage(
                  image: widget.image,
                  networkImage: true,
                ),
              );
            },
            child: ClipRRect(
              borderRadius: borderRadius10,
              child: OptimizedCacheImage(
                fadeInCurve: Curves.ease,
                imageUrl: widget.image,
                imageBuilder: (context, imageProvider) => Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: borderRadius10,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                placeholder: (context, url) => Loading(),
                errorWidget: (context, url, error) => NoImage(),
              ),
            ),
          ),
        ),
        Yakalar()
      ],
    );
  }

  Expanded Yakalar() {
    return Expanded(
      child: ListView.separated(
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
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
                  child: OptimizedCacheImage(
                    fadeInCurve: Curves.ease,
                    imageUrl: list[index].machineLogo!,
                    imageBuilder: (context, imageProvider) => Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: borderRadius5,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Loading(),
                    errorWidget: (context, url, error) => NoImage(),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 6),
                  child: Text(
                    list[index].machineName ?? 'Yaka',
                    style: TextStyle(
                      color: list[index].purchased! ? Colors.green.withOpacity(0.6) : Colors.black,
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
                        color: list[index].purchased! ? Colors.green.withOpacity(0.6) : Colors.red,
                        fontSize: 20,
                        fontFamily: normProBold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        ' TMT',
                        style: TextStyle(
                          color: list[index].purchased! ? Colors.green.withOpacity(0.6) : Colors.red,
                          fontSize: 11,
                          fontFamily: normsProMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    list[index].purchased! == false ? askToDownloadYaka(index) : downloadYaka(index);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8, left: 8),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: list[index].purchased! ? Colors.green.withOpacity(0.4) : kPrimaryColor, borderRadius: borderRadius10),
                    child: list[index].purchased!
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
    );
  }

  Future<dynamic> askToDownloadYaka(int index) {
    return Get.defaultDialog(
      title: 'Üns ber',
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      titlePadding: const EdgeInsets.only(top: 15),
      titleStyle: const TextStyle(color: Colors.black, fontFamily: normProBold, fontSize: 22),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              'wantToBuyCollar'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black, fontSize: 20),
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
                      backgroundColor: kPrimaryColor,
                      elevation: 0,
                      shape: const RoundedRectangleBorder(borderRadius: borderRadius10),
                      padding: const EdgeInsets.all(10),
                    ),
                    child: Text(
                      'agree'.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: normProBold),
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
                      backgroundColor: Colors.grey.withOpacity(0.6),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(borderRadius: borderRadius10),
                      padding: const EdgeInsets.all(10),
                    ),
                    child: Text(
                      'no'.tr,
                      style: const TextStyle(
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
