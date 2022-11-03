// ignore_for_file: always_put_required_named_parameters_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/modules/buttons/fav_button.dart';
import 'package:yaka2/app/modules/product_profil/views/product_profil_view.dart';

class HomePageCard extends StatelessWidget {
  final List image;
  final String name;
  final int id;
  final String price;
  final List files;
  const HomePageCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.id,
    required this.files,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(left: 15, bottom: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.32,
          backgroundColor: kPrimaryColorCard,
          padding: const EdgeInsets.only(left: 3, right: 3, top: 8, bottom: 5),
          shape: const RoundedRectangleBorder(borderRadius: borderRadius10),
        ),
        onPressed: () {
          Get.to(
            () => ProductProfilView(
              files: files,
              image: image,
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
              child: CarouselSlider.builder(
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
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: FavButton(
              whcihPage: false,
              id: id,
            ),
          )
        ],
      ),
    );
  }

  Container namePart1() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 4, left: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
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
            ],
          ),
          GestureDetector(
            onTap: () {
              downloadFiles(list: files);
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
          )
        ],
      ),
    );
  }
}
