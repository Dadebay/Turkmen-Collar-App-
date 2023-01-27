import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/modules/home/views/banner_profile_view.dart';

class BannerCard extends StatelessWidget {
  final String image;
  final String name;
  final String description;

  const BannerCard({
    required this.image,
    required this.name,
    required this.description,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(image);
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.to(() => BannerProfileView(name, image, description));
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        width: size.width,
        decoration: const BoxDecoration(
          borderRadius: borderRadius10,
        ),
        child: ClipRRect(
          borderRadius: borderRadius10,
          child: CachedNetworkImage(
            fadeInCurve: Curves.ease,
            imageUrl: image,
            imageBuilder: (context, imageProvider) => Container(
              width: size.width,
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
    );
  }
}
