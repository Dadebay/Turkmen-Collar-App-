import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/banner_model.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';
import 'package:yaka2/app/modules/product_profil/views/product_profil_view.dart';

class ListviewMachinesView extends GetView {
  ListviewMachinesView({Key? key}) : super(key: key);
  final HomeController bannerController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BannerModel>>(
      future: bannerController.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: spinKit());
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.data!.isEmpty) {
          return const Text('No Kategory Image');
        }
        print(DateTime.now().toString());
        return Container(
          height: 240,
          margin: const EdgeInsets.only(top: 25),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              namePart(text: 'machines'),
              Expanded(
                child: ListView.builder(
                  itemCount: 8,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 310,
                      margin: const EdgeInsets.only(left: 15, bottom: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(
                            () => ProductProfilView(
                              'assets/image/machine/${index + 1}.png',
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0.3,
                          backgroundColor: kPrimaryColorCard,
                          padding: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(borderRadius: borderRadius10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                width: Get.size.width,
                                height: Get.size.height,
                                decoration: const BoxDecoration(
                                  borderRadius: borderRadius10,
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(8),
                                child: ClipRRect(
                                  borderRadius: borderRadius10,
                                  child: Image.asset(
                                    'assets/image/machine/${index + 1}.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      'Yaka masyn ady',
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.black, fontSize: 19),
                                    ),
                                    Text(
                                      machineName[index],
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 17,
                                        fontFamily: normsProMedium,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        '4780 TMT',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 19,
                                          fontFamily: normProBold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      DateTime.now().toString().substring(0, 10),
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontFamily: normsProRegular,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
