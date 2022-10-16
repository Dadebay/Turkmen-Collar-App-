// ignore_for_file: always_put_required_named_parameters_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/modules/buttons/fav_button.dart';
import 'package:yaka2/app/modules/product_profil/views/product_profil_view.dart';

class HomePageCard extends StatelessWidget {
  final int index;
  final bool second;
  const HomePageCard({super.key, required this.index, required this.second});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(left: 15, bottom: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.32,
          backgroundColor: kPrimaryColorCard,
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 5),
          shape: const RoundedRectangleBorder(borderRadius: borderRadius10),
        ),
        onPressed: () {
          Get.to(() => ProductProfilView(
                second ? 'assets/image/clothes/${index + 1}.png' : 'assets/image/yaka/${index + 1}.png',
              ));
        },
        child: Column(
          children: [
            imagePart(index),
            namePart1(index),
          ],
        ),
      ),
    );
  }

  Expanded imagePart(int index) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: borderRadius10,
              child: Image.asset(
                second ? 'assets/image/clothes/${index + 1}.png' : 'assets/image/yaka/${index + 1}.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Positioned(
            top: 8,
            right: 8,
            child: FavButton(),
          )
        ],
      ),
    );
  }

  Padding namePart1(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Yaka ady',
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
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              '50 TMT',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.red,
                fontSize: 17,
                fontFamily: normProBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
