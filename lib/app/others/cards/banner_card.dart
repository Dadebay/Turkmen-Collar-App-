import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/error_state/no_image.dart';
import 'package:yaka2/app/modules/home/views/banner_profile_view.dart';

import '../../constants/loadings/loading.dart';

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
          child: OptimizedCacheImage(
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
            placeholder: (context, url) => Loading(),
            errorWidget: (context, url, error) => NoImage(),
          ),
        ),
      ),
    );
  }
}
