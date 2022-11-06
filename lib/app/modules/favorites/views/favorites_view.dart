import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';

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
        itemCount: Get.find<FavoritesController>().favList.length,
        itemBuilder: (context, index) {
          return const Text('as');
        },
        staggeredTileBuilder: (index) => const StaggeredTile.count(1, 1.5),
      ),
    );
  }
}
