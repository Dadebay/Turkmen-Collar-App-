import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';

class DownloadedView extends GetView {
  const DownloadedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemCount: 13,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          // child:
          //  ProductCard(
          //   downloadable: true,
          // ),
        ),
        staggeredTileBuilder: (index) => const StaggeredTile.count(1, 1.5),
      ),
    );
  }
}
