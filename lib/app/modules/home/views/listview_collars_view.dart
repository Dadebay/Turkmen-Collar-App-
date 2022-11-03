import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/collar_model.dart';
import 'package:yaka2/app/data/services/collars_service.dart';
import 'package:yaka2/app/modules/cards/home_product_card.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';
import 'package:yaka2/app/modules/home/views/show_all_products_view.dart';

class ListviewCollarsView extends GetView {
  final HomeController homeController = Get.put(HomeController());

  ListviewCollarsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CollarModel>>(
      // future: homeController.collars,
      future: CollarService().getCollars(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: spinKit());
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.data!.isEmpty) {
          return const Text('No Kategory Image');
        }
        return Container(
          height: 320,
          margin: const EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              namePart(
                text: 'collars',
                onTap: () {
                  Get.to(
                    () => const ShowAllProductsView(
                      name: 'collars',
                      which: true,
                    ),
                  );
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return HomePageCard(
                      image: snapshot.data![index].images ?? [],
                      name: '${snapshot.data![index].name}',
                      price: '${snapshot.data![index].price}',
                      id: snapshot.data![index].id!,
                      files: snapshot.data![index].files!,
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
