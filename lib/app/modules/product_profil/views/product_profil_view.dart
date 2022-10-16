import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';

import '../controllers/product_profil_controller.dart';

class ProductProfilView extends GetView<ProductProfilController> {
  final String image;
  ProductProfilView(this.image, {Key? key}) : super(key: key);
  final ProductProfilController _productProfilController = Get.put(ProductProfilController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        width: Get.size.width,
        margin: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: borderRadius20,
        ),
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: const Text(
          'Ýükle',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: normProBold),
        ),
      ),
      body: NestedScrollView(
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
                  const Text(
                    'Yaka ady',
                    style: TextStyle(color: Colors.black, fontFamily: normsProMedium, fontSize: 24),
                  ),
                  Row(
                    children: const [
                      Text(
                        '170',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                          fontFamily: normProBold,
                        ),
                      ),
                      Padding(
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
              Image.asset(
                'assets/image/logo/janome.jpg',
                width: 100,
                height: 70,
              ),
              twoText(name1: 'Maşyn ady :', name2: 'Janome'),
              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ),
              twoText(name1: 'Kategoriýa :', name2: 'Balak'),
              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ),
              twoText(name1: 'Görülme Sany :', name2: '1253'),
              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ),
              twoText(name1: 'Ýüklenme Sany :', name2: '521'),
              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30, bottom: 10),
                child: Text(
                  'Goşmaça Maglumat :',
                  style: TextStyle(color: Colors.black, fontFamily: normsProMedium, fontSize: 20),
                ),
              ),
              const Text(
                'Lorem Ipsum, kısaca Lipsum, masaüstü yayıncılık ve basın yayın sektöründe kullanılan taklit yazı bloğu olarak tanımlanır. Lipsum, oluşturulacak şablon ve taslaklarda içerik yerine geçerek yazı bloğunu doldurmak için kullanılır,Lorem Ipsum, kısaca Lipsum, masaüstü yayıncılık ve basın yayın sektöründe kullanılan taklit yazı bloğu olarak tanımlanır. Lipsum, oluşturulacak şablon ve taslaklarda içerik yerine geçerek yazı bloğunu doldurmak için kullanılır',
                style: TextStyle(fontFamily: normsProLight, fontSize: 18, color: Colors.black54),
              )
            ],
          ),
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
      // systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
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
        Container(
          margin: const EdgeInsets.only(top: 4, bottom: 4, right: 8),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          decoration: const BoxDecoration(
            borderRadius: borderRadius15,
            color: Colors.white,
          ),
          child: const Icon(
            IconlyLight.heart,
            color: Colors.black,
          ),
        ),
        Container(
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
      ],
      flexibleSpace: Container(
        color: Colors.grey.shade200,
        margin: const EdgeInsets.only(top: 30),
        child: CarouselSlider.builder(
          itemCount: 7,
          itemBuilder: (context, index, count) {
            return Image.asset(
              index == 0 ? image : 'assets/image/yaka/${index + 1}.png',
              fit: BoxFit.cover,
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
