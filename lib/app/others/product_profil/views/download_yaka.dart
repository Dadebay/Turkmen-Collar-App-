import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/collar_model.dart';

import '../../../modules/home/controllers/home_controller.dart';

class DownloadYakaPage extends StatelessWidget {
  DownloadYakaPage({Key? key, required this.image, required this.list}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());
  final String image;
  final List<FilesModel> list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          'cart'.tr,
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
      ),
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
                return Row(
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
}
