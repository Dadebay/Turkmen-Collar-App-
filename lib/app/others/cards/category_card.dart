import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:yaka2/app/constants/error_state/no_image.dart';
import 'package:yaka2/app/modules/home/views/show_all_products_view.dart';

import '../../constants/constants.dart';
import '../../constants/loadings/loading.dart';

class CategoryCard extends StatelessWidget {
  final int id;
  final String name;
  final String image;
  const CategoryCard({
    required this.id,
    required this.name,
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ShowAllProductsView(
            name: name,
            id: id,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 25, bottom: 10),
        child: OptimizedCacheImage(
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
          placeholder: (context, url) => Loading(),
          errorWidget: (context, url, error) => NoImage(),
        ),
      ),
    );
  }
}
