import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/data/models/machines_model.dart';
import 'package:yaka2/app/data/services/machines_service.dart';

import '../../../constants/widgets.dart';
import '../controllers/product_profil_controller.dart';

class MachinesProductProfil extends GetView<ProductProfilController> {
  final ProductProfilController _productProfilController = Get.put(ProductProfilController());

  final int id;
  final List image;
  MachinesProductProfil({
    super.key,
    required this.id,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: orderButton(),
      body: FutureBuilder<MachineModel>(
        future: MachineService().getMachineByID(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (snapshot.hasError) {
            return const Text('Error');
          }
          return NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [appBar()];
            },
            body: Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        snapshot.data!.name!,
                        style: const TextStyle(color: Colors.black, fontFamily: normsProMedium, fontSize: 24),
                      ),
                      Row(
                        children: [
                          Text(
                            '${snapshot.data!.price}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                              fontFamily: normProBold,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 6, top: 7),
                            child: Text(
                              ' TMT',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontFamily: normProBold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey.shade300,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 10),
                    child: Text(
                      'data5'.tr,
                      style: const TextStyle(color: Colors.black, fontFamily: normsProMedium, fontSize: 20),
                    ),
                  ),
                  Text(
                    snapshot.data!.description!,
                    style: const TextStyle(fontFamily: normsProLight, fontSize: 18, color: Colors.black54),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget orderButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: Get.size.width,
        margin: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: borderRadius20,
        ),
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          'order'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: normProBold),
        ),
      ),
    );
  }

  AnimatedContainer dot(int index) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
      height: 16,
      width: 18,
      decoration: BoxDecoration(
        color: _productProfilController.imageDotIndex.value == index ? kPrimaryColor : Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Padding twoText({required String name1, required String name2}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name1.tr,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontFamily: normsProLight,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              name2.tr,
              maxLines: 2,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: normsProMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar appBar() {
    return SliverAppBar(
      expandedHeight: 400,
      floating: true,
      pinned: false,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.grey.shade200,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          margin: const EdgeInsets.only(top: 4, bottom: 4, left: 8),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          decoration: const BoxDecoration(
            borderRadius: borderRadius15,
            color: Colors.white,
          ),
          child: const Icon(
            IconlyLight.arrowLeftCircle,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Share.share(image[0], subject: appName);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 4, bottom: 4, right: 8),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            decoration: const BoxDecoration(
              borderRadius: borderRadius15,
              color: Colors.white,
            ),
            child: Image.asset(
              shareIcon,
              width: 24,
              height: 24,
              color: Colors.black,
            ),
          ),
        ),
      ],
      flexibleSpace: Container(
        color: Colors.grey.shade200,
        margin: const EdgeInsets.only(top: 30),
        child: CarouselSlider.builder(
          itemCount: image.length,
          itemBuilder: (context, index, count) {
            return CachedNetworkImage(
              fadeInCurve: Curves.ease,
              imageUrl: image[index],
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
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
            onPageChanged: (index, CarouselPageChangedReason a) {
              _productProfilController.imageDotIndex.value = index;
            },
            viewportFraction: 1.0,
            autoPlay: true,
            height: Get.size.height,
            aspectRatio: 4 / 2,
            scrollPhysics: const BouncingScrollPhysics(),
            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
            autoPlayAnimationDuration: const Duration(milliseconds: 2000),
          ),
        ),
      ),
    );
  }
}
