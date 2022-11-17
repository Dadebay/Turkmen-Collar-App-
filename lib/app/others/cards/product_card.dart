// ignore_for_file: always_put_required_named_parameters_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/collar_model.dart';
import 'package:yaka2/app/others/buttons/add_cart_button.dart';
import 'package:yaka2/app/others/product_profil/views/download_yaka.dart';

import '../../data/services/auth_service.dart';
import '../buttons/fav_button.dart';
import '../product_profil/views/product_profil_view.dart';

class ProductCard extends StatelessWidget {
  final List image;
  final String name;
  final String createdAt;
  final int id;
  final String price;
  final List<FilesModel> files;
  final bool downloadable;
  final bool? removeAddCard;
  const ProductCard({required this.image, required this.createdAt, required this.name, required this.price, required this.id, required this.files, required this.downloadable, this.removeAddCard});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.32,
          primary: kPrimaryColorCard,
          padding: const EdgeInsets.only(left: 3, right: 3, top: 8, bottom: 5),
          shape: const RoundedRectangleBorder(borderRadius: borderRadius10),
        ),
        onPressed: () {
          Get.to(
            () => ProductProfilView(
              downloadable: downloadable,
              files: files,
              price: price,
              image: image,
              name: name,
              createdAt: createdAt,
              id: id,
            ),
          );
        },
        child: Column(
          children: [
            imagePart(),
            namePart1(),
          ],
        ),
      ),
    );
  }

  Expanded imagePart() {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: borderRadius10,
              child: image.length != 1
                  ? CarouselSlider.builder(
                      itemCount: image.length,
                      itemBuilder: (context, index, count) {
                        return CachedNetworkImage(
                          fadeInCurve: Curves.ease,
                          imageUrl: image[index],
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
                          placeholder: (context, url) => Center(child: spinKit()),
                          errorWidget: (context, url, error) => noBannerImage(),
                        );
                      },
                      options: CarouselOptions(
                        onPageChanged: (index, CarouselPageChangedReason a) {},
                        viewportFraction: 1.0,
                        autoPlay: false,
                        height: Get.size.height,
                        aspectRatio: 4 / 2,
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                        autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                      ),
                    )
                  : CachedNetworkImage(
                      fadeInCurve: Curves.ease,
                      imageUrl: image[0],
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
                      placeholder: (context, url) => Center(child: spinKit()),
                      errorWidget: (context, url, error) => noBannerImage(),
                    ),
            ),
          ),
          removeAddCard!
              ? SizedBox.shrink()
              : Positioned(
                  top: 12,
                  right: 12,
                  child: FavButton(
                    isCollar: downloadable,
                    whcihPage: false,
                    name: name,
                    id: id,
                  ),
                )
        ],
      ),
    );
  }

  Container namePart1() {
    final double a = double.parse(price.toString());
    final double b = a / 100.0;
    return Container(
      width: double.infinity,
      padding: removeAddCard! ? EdgeInsets.only(top: 8, bottom: 8, left: 5) : EdgeInsets.only(top: 4, left: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  name,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${b.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 19,
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
              ),
            ],
          ),
          removeAddCard!
              ? SizedBox.shrink()
              : downloadable
                  ? downloadButton()
                  : AddCartButton(
                      id: id,
                      price: price,
                      productProfil: false,
                      createdAt: createdAt,
                      image: image[0],
                      name: name,
                    )
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
        } else {
          files.length == 0
              ? showSnackBar('error', 'noFile', Colors.red)
              : Get.to(
                  () => DownloadYakaPage(
                    image: image[0],
                    list: files,
                    pageName: name,
                  ),
                );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 4),
        width: Get.size.width,
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
