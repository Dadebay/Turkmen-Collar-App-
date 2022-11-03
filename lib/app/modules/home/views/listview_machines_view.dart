import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/machines_model.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';

import '../../cards/machine_card.dart';

class ListviewMachinesView extends GetView {
  ListviewMachinesView({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MachineModel>>(
      future: homeController.machines,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: spinKit());
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.data!.isEmpty) {
          return const Text('No Kategory Image');
        }
        return Container(
          height: 240,
          margin: const EdgeInsets.only(top: 25),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              namePart(text: 'machines', onTap: () {}),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return MachineCard(
                      id: snapshot.data![index].id!,
                      image: snapshot.data![index].images!,
                      name: '${snapshot.data![index].name}',
                      price: '${snapshot.data![index].price}',
                      description: '${snapshot.data![index].description}',
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
