import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/data/models/clothes_model.dart';
import 'package:yaka2/app/data/models/collar_model.dart';
import 'package:yaka2/app/data/services/collars_service.dart';
import 'package:yaka2/app/data/services/dresses_service.dart';
import 'package:yaka2/app/others/buttons/add_cart_button.dart';
import 'package:yaka2/app/others/buttons/fav_button.dart';
import 'package:yaka2/app/others/product_profil/views/photo_view.dart';

import '../../../constants/widgets.dart';
import '../../../data/services/auth_service.dart';
import '../controllers/product_profil_controller.dart';
import 'download_yaka.dart';

class ProductProfilView extends StatefulWidget {
  final int id;
  final bool downloadable;
  final String price;
  final String name;
  final String createdAt;
  final List image;
  final List<FilesModel> files;
  ProductProfilView({
    required this.id,
    required this.price,
    required this.name,
    required this.createdAt,
    required this.downloadable,
    required this.image,
    required this.files,
  });

  @override
  State<ProductProfilView> createState() => _ProductProfilViewState();
}

class _ProductProfilViewState extends State<ProductProfilView> {
  final ProductProfilController _productProfilController = Get.put(ProductProfilController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          downloadButton(),
        ],
      ),
      body: widget.downloadable ? downloadablePage() : orderPage(),
    );
  }

  FutureBuilder<DressesModel> orderPage() {
    return FutureBuilder<DressesModel>(
      future: DressesService().getDressesByID(widget.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: spinKit());
        } else if (snapshot.hasError) {
          return errorPage(
            onTap: () {
              DressesService().getDressesByID(widget.id);
            },
          );
        }
        final double a = double.parse(snapshot.data!.price.toString());
        final double b = a / 100.0;
        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [appBar()];
          },
          body: testPart(
            name: snapshot.data!.name!,
            price: b,
            machineName: '',
            category: snapshot.data!.category!,
            downloads: '${snapshot.data!.createdAt!}',
            views: '${snapshot.data!.views!}',
            desc: snapshot.data!.description!,
          ),
        );
      },
    );
  }

  FutureBuilder<CollarModel> downloadablePage() {
    return FutureBuilder<CollarModel>(
      future: CollarService().getCollarsByID(widget.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: spinKit());
        } else if (snapshot.hasError) {
          return errorPage(
            onTap: () {
              CollarService().getCollarsByID(widget.id);
            },
          );
        }
        final double a = double.parse(snapshot.data!.price.toString());
        final double b = a / 100.0;

        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [appBar()];
          },
          body: testPart(
            name: snapshot.data!.name!,
            price: b,
            machineName: snapshot.data!.machineName!,
            category: snapshot.data!.category!,
            downloads: '${snapshot.data!.downloads!}',
            views: '${snapshot.data!.views!}',
            desc: snapshot.data!.description!,
          ),
        );
      },
    );
  }

  Widget testPart({required String name, required double price, required String machineName, required String category, required String views, required String downloads, required String desc}) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(color: Colors.black, fontFamily: normsProMedium, fontSize: 24),
            ),
            Row(
              children: [
                Text(
                  '${price}',
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
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 10),
          child: Text(
            'data'.tr,
            style: const TextStyle(color: Colors.black, fontFamily: normsProMedium, fontSize: 20),
          ),
        ),
        widget.downloadable ? twoText(name1: 'data1', name2: machineName) : SizedBox.shrink(),
        widget.downloadable
            ? Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              )
            : SizedBox.shrink(),
        twoText(name1: 'data2', name2: category),
        Divider(
          thickness: 1,
          color: Colors.grey.shade300,
        ),
        twoText(name1: 'data3', name2: views),
        Divider(
          thickness: 1,
          color: Colors.grey.shade300,
        ),
        widget.downloadable ? SizedBox.shrink() : twoText(name1: 'createdAt', name2: downloads),
        widget.downloadable
            ? SizedBox.shrink()
            : Divider(
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
          desc,
          style: const TextStyle(fontFamily: normsProLight, fontSize: 18, color: Colors.black54),
        )
      ],
    );
  }

  Widget downloadButton() {
    return widget.downloadable
        ? GestureDetector(
            onTap: () async {
              final token = await Auth().getToken();
              print(token);
              if (token == null) {
                showSnackBar('loginError', 'loginErrorSubtitle1', Colors.red);
              } else {
                widget.files.length == 0
                    ? showSnackBar('error', 'noFile', Colors.red)
                    : Get.to(
                        () => DownloadYakaPage(
                          image: widget.image[0],
                          list: widget.files,
                          pageName: widget.name,
                        ),
                      );
              }
            },
            child: Container(
              width: Get.size.width,
              margin: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: borderRadius20,
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'download'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 22, fontFamily: normProBold),
              ),
            ),
          )
        : AddCartButton(
            id: widget.id,
            price: widget.price,
            productProfil: true,
            createdAt: widget.createdAt,
            name: widget.name,
            image: widget.image[0],
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
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4, right: 8),
          child: FavButton(
            whcihPage: true,
            name: widget.name,
            id: widget.id,
            isCollar: widget.downloadable,
          ),
        ),
        GestureDetector(
          onTap: () {
            Share.share(widget.image[0], subject: appName);
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
          itemCount: widget.image.length,
          itemBuilder: (context, index, count) {
            return GestureDetector(
              onTap: () {
                Get.to(() => PhotoViewPage(image: widget.image[index]));
              },
              child: CachedNetworkImage(
                fadeInCurve: Curves.ease,
                imageUrl: widget.image[index],
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
              ),
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
