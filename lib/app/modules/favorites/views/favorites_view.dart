import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/clothes_model.dart';
import 'package:yaka2/app/data/models/collar_model.dart';
import 'package:yaka2/app/data/services/fav_service.dart';
import 'package:yaka2/app/others/cards/product_card.dart';

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
        appBar: AppBar(
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
        ),
        body: TabBarView(
          children: [
            FutureBuilder<List<CollarModel>>(
              future: FavService().getCollarFavList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: spinKit(),
                  );
                } else if (snapshot.hasError) {
                  return errorPage(
                    onTap: () {
                      FavService().getCollarFavList();
                    },
                  );
                } else if (snapshot.data!.isEmpty) {
                  return emptyPageImage(
                    name: 'emptyFavoriteSubtitle'.tr,
                    onTap: () {
                      FavService().getCollarFavList();
                    },
                  );
                }

                return StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: snapshot.data!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      image: snapshot.data![index].images ?? [],
                      name: '${snapshot.data![index].name}',
                      price: '${snapshot.data![index].price}',
                      id: snapshot.data![index].id!,
                      files: snapshot.data![index].files!,
                      downloadable: true,
                      removeAddCard: false,
                      createdAt: snapshot.data![index].createdAt!,
                    );
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.count(1, index % 2 == 0 ? 1.4 : 1.5),
                );
              },
            ),
            FutureBuilder<List<DressesModel>>(
              future: FavService().getProductFavList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: spinKit(),
                  );
                } else if (snapshot.hasError) {
                  return errorPage(
                    onTap: () {
                      FavService().getProductFavList();
                    },
                  );
                } else if (snapshot.data!.isEmpty) {
                  return emptyPageImage(
                    name: 'emptyFavoriteSubtitle'.tr,
                    onTap: () {
                      FavService().getProductFavList();
                    },
                  );
                }
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: snapshot.data!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      image: snapshot.data![index].images ?? [],
                      name: snapshot.data![index].name ?? 'asd',
                      price: '${snapshot.data![index].price ?? 00}',
                      id: snapshot.data![index].id!,
                      downloadable: false,
                      files: const [],
                      removeAddCard: false,
                      createdAt: snapshot.data![index].createdAt ?? 'asd',
                    );
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.count(1, index % 2 == 0 ? 1.3 : 1.5),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
