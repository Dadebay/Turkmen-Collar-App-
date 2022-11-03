import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/widgets.dart';

import '../../constants/constants.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);

  final String name;
  final String image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(() => ShowAllProductsView(name));
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 25, bottom: 10),
            child: CachedNetworkImage(
              fadeInCurve: Curves.ease,
              imageUrl: image,
              imageBuilder: (context, imageProvider) => Container(
                width: Get.size.width,
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
          Container(
            width: Get.size.width,
            height: Get.size.height,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(left: 10, top: 25, bottom: 10),
            decoration: const BoxDecoration(
              color: Colors.black54,
              borderRadius: borderRadius10,
            ),
            alignment: Alignment.center,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontFamily: normProBold, fontSize: 30),
            ),
          )
        ],
      ),
    );
  }
}
