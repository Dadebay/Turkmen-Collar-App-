// ignore_for_file: always_put_required_named_parameters_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/error_state/no_image.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/others/buttons/fav_button.dart';

import '../../constants/loadings/loading.dart';
import '../../data/services/auth_service.dart';
import '../../modules/auth/sign_in_page/views/tabbar_view.dart';
import '../buttons/add_cart_button.dart';
import '../product_profil/views/download_yaka.dart';
import '../product_profil/views/product_profil_view.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String createdAt;
  final int id;
  final String price;
  final bool downloadable;
  const ProductCard({
    super.key,
    required this.image,
    required this.createdAt,
    required this.name,
    required this.price,
    required this.id,
    required this.downloadable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 1.0,
          backgroundColor: kPrimaryColorCard,
          padding: const EdgeInsets.only(left: 3, right: 3, top: 8, bottom: 5),
          shape: const RoundedRectangleBorder(borderRadius: borderRadius10),
        ),
        onPressed: () {
          Get.to(
            () => ProductProfilView(
              downloadable: downloadable,
              price: price,
              image: image,
              name: name,
              createdAt: createdAt,
              id: id,
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImagePart(),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontFamily: normProBold,
                        ),
                      ),
                      const Padding(
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
                  Text(
                    name,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black, fontFamily: normsProLight, fontSize: 14),
                  ),
                ],
              ),
            ),
            downloadable
                ? downloadButton()
                : AddCartButton(
                    id: id,
                    price: price,
                    productProfil: false,
                    createdAt: createdAt,
                    image: image,
                    name: name,
                  ),
          ],
        ),
      ),
    );
  }

  Expanded ImagePart() {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: borderRadius10,
              child: OptimizedCacheImage(
                fadeInCurve: Curves.ease,
                imageUrl: image,
                imageBuilder: (context, imageProvider) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
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
          Positioned(
            top: 8,
            right: 15,
            child: FavButton(whcihPage: false, isCollar: true, id: id, name: name),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              logo1,
              width: 50,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector downloadButton() {
    return GestureDetector(
      onTap: () async {
        final token = await Auth().getToken();
        if (token == null) {
          showSnackBar('loginError', 'loginErrorSubtitle1', Colors.red);
          await Get.to(() => const TabbarView());
        } else {
          await Get.to(
            () => DownloadYakaPage(
              image: image,
              id: id,
              pageName: name,
            ),
          );
        }
      },
      child: Container(
        width: Get.size.width,
        margin: const EdgeInsets.only(top: 4),
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: const BoxDecoration(
          borderRadius: borderRadius5,
          color: kPrimaryColor,
        ),
        child: Text(
          'download'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontFamily: normsProMedium),
        ),
      ),
    );
  }
}
