import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/loaders.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/collar_model.dart';
import 'package:yaka2/app/data/services/collars_service.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';
import 'package:yaka2/app/others/cards/product_card.dart';

class ListviewCollarsView extends GetView {
  final HomeController homeController = Get.put(HomeController());

  ListviewCollarsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          namePart(
            text: 'collars',
            removeIcon: true,
            onTap: () {},
          ),
          Expanded(
            child: FutureBuilder<List<CollarModel>>(
              future: CollarService().getCollars(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loaderCollar();
                } else if (snapshot.hasError) {
                  return errorPage(
                    onTap: () {
                      CollarService().getCollars();
                    },
                  );
                } else if (snapshot.data!.isEmpty) {
                  return emptryPageText();
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
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
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
