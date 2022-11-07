import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/others/buttons/add_cart_button.dart';

class CardCart extends StatelessWidget {
  const CardCart({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.createdAt,
    required this.id,
  }) : super(key: key);
  final int id;
  final String name;
  final String image;
  final String price;
  final String createdAt;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      height: Get.size.height / 5,
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          elevation: 0.3,
          primary: kGreyColor,
          padding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(borderRadius: borderRadius15),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(12),
                width: Get.size.width,
                height: Get.size.height,
                decoration: const BoxDecoration(
                  borderRadius: borderRadius10,
                  color: Colors.white,
                ),
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
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 14, bottom: 10, left: 14, right: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black, fontSize: 19),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            price,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 21,
                              fontFamily: normProBold,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              ' TMT',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontFamily: normsProMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      createdAt,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: normsProRegular,
                      ),
                    ),
                    AddCartButton(
                      id: id,
                      price: price,
                      productProfil: false,
                      createdAt: createdAt,
                      image: '',
                      name: name,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
