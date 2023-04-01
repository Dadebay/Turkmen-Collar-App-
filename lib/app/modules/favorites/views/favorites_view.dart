import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/empty_state/empty_state.dart';
import 'package:yaka2/app/constants/error_state/error_state.dart';
import 'package:yaka2/app/constants/loadings/loading.dart';
import 'package:yaka2/app/data/models/collar_model.dart';
import 'package:yaka2/app/data/services/fav_service.dart';
import 'package:yaka2/app/others/cards/product_card.dart';

import '../../../data/models/clothes_model.dart';
import '../controllers/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  @override
  final FavoritesController controller = Get.put(FavoritesController());

  FavoritesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appBar(),
        body: TabBarView(
          children: [
            firstpage(),
            secondPage(),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<DressesModelFavorites>> secondPage() {
    return FutureBuilder<List<DressesModelFavorites>>(
      future: FavService().getProductFavList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else if (snapshot.hasError) {
          return ErrorState(
            onTap: () {
              FavService().getProductFavList();
            },
          );
        } else if (snapshot.data!.isEmpty) {
          return EmptyState(name: 'emptyFavoriteSubtitle');
        }
        return GridView.builder(
          itemCount: snapshot.data!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 9 / 14),
          itemBuilder: (BuildContext context, int index) {
            final double a = double.parse(snapshot.data![index].price.toString());
            final double b = a / 100.0;
            return ProductCard(
              categoryName: '',
              image: snapshot.data![index].image!,
              name: snapshot.data![index].name ?? 'asd',
              price: b.toString(),
              id: snapshot.data![index].id!,
              downloadable: false,
              createdAt: snapshot.data![index].createdAt ?? 'asd',
            );
          },
        );
      },
    );
  }

  FutureBuilder<List<FavoritesModelCollar>> firstpage() {
    return FutureBuilder<List<FavoritesModelCollar>>(
      future: FavService().getCollarFavList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else if (snapshot.hasError) {
          return ErrorState(
            onTap: () {
              FavService().getProductFavList();
            },
          );
        } else if (snapshot.data!.isEmpty) {
          return EmptyState(name: 'emptyFavoriteSubtitle');
        }
        return GridView.builder(
          itemCount: snapshot.data!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 9 / 14),
          itemBuilder: (BuildContext context, int index) {
            final double a = double.parse(snapshot.data![index].price.toString());
            final double b = a / 100.0;
            return ProductCard(
              categoryName: '',
              image: snapshot.data![index].image!,
              name: '${snapshot.data![index].name}',
              price: b.toString(),
              id: snapshot.data![index].id!,
              downloadable: true,
              createdAt: snapshot.data![index].createdAt!,
            );
          },
        );
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        'favorites'.tr,
        style: const TextStyle(fontFamily: normProBold, color: Colors.black),
      ),
      backgroundColor: kPrimaryColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          IconlyLight.arrowLeftCircle,
          color: Colors.black,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarIconBrightness: Brightness.dark),
      centerTitle: true,
      bottom: TabBar(
        labelStyle: const TextStyle(fontFamily: normsProMedium, fontSize: 20),
        unselectedLabelStyle: const TextStyle(fontFamily: normsProLight, fontSize: 18),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.white70,
        labelPadding: const EdgeInsets.only(top: 8, bottom: 4),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.black,
        indicatorWeight: 3,
        tabs: [
          Tab(
            text: 'collar'.tr,
          ),
          Tab(
            text: 'products'.tr,
          ),
        ],
      ),
    );
  }
}
