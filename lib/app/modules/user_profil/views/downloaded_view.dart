import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/modules/buttons/product_card.dart';

class DownloadedView extends GetView {
  const DownloadedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('downloaded'.tr),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.white,
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemCount: 13,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProductCard(
            index: index,
            downloadable: true,
            removeFavButton: true,
          ),
        ),
        staggeredTileBuilder: (index) => const StaggeredTile.count(1, 1.5),
      ),
    );
  }
}
