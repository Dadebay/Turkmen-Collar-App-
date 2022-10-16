import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/modules/buttons/product_card.dart';

import '../controllers/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('favorites'.tr),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.white,
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemCount: 7,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProductCard(
            index: index,
            downloadable: false,
            removeFavButton: false,
          ),
        ),
        staggeredTileBuilder: (index) => const StaggeredTile.count(1, 1.5),
      ),
    );
  }
}
