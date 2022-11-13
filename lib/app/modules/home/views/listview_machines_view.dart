import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/loaders.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/machines_model.dart';
import 'package:yaka2/app/data/services/machines_service.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';
import 'package:yaka2/app/others/cards/machine_card.dart';

class ListviewMachinesView extends GetView {
  ListviewMachinesView({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: const EdgeInsets.only(top: 25),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          namePart(
            text: 'machines',
            removeIcon: true,
            onTap: () {},
          ),
          Expanded(
            child: FutureBuilder<List<MachineModel>>(
              future: homeController.machines,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loaderMachines();
                } else if (snapshot.hasError) {
                  return errorPage(
                    onTap: () {
                      MachineService().getMachines();
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
                    return MachineCard(
                      model: snapshot.data![index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
