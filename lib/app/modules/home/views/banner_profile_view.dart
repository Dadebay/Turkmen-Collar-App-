import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/error_state/no_image.dart';
import 'package:yaka2/app/constants/loadings/loading.dart';

class BannerProfileView extends GetView {
  final String description;
  final String pageName;
  final String image;

  const BannerProfileView(this.pageName, this.image, this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pageName,
          style: const TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            IconlyLight.arrowLeftCircle,
            color: Colors.black,
          ),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarIconBrightness: Brightness.dark),
      ),
      body: Column(
        children: [
          OptimizedCacheImage(
            fadeInCurve: Curves.ease,
            imageUrl: image,
            imageBuilder: (context, imageProvider) => Container(
              width: size.width,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            placeholder: (context, url) => Loading(),
            errorWidget: (context, url, error) => NoImage(),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              description,
              style: const TextStyle(fontSize: 20, fontFamily: normsProLight),
            ),
          )
        ],
      ),
    );
  }
}
