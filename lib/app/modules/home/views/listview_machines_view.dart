import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/empty_state/empty_state_text.dart';
import 'package:yaka2/app/constants/error_state/error_state.dart';
import 'package:yaka2/app/constants/loadings/machine_loading.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/machines_model.dart';
import 'package:yaka2/app/data/services/machines_service.dart';
import 'package:yaka2/app/others/cards/machine_card.dart';

class ListviewMachinesView extends GetView {
  ListviewMachinesView({Key? key}) : super(key: key);

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
              future: MachineService().getMachines(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return MachineLoading();
                } else if (snapshot.hasError) {
                  return ErrorState(
                    onTap: () {
                      MachineService().getMachines();
                    },
                  );
                } else if (snapshot.data!.isEmpty) {
                  return EmptyStateText();
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  addAutomaticKeepAlives: true,
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
