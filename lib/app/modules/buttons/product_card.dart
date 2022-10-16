import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/modules/product_profil/views/product_profil_view.dart';

import 'download_button.dart';
import 'fav_button.dart';

class ProductCard extends StatelessWidget {
  final int index;
  final bool downloadable;
  final bool removeFavButton;
  const ProductCard({super.key, required this.index, required this.downloadable, required this.removeFavButton});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        elevation: 2,
        shape: const RoundedRectangleBorder(borderRadius: borderRadius10),
      ),
      onPressed: () {
        Get.to(
          () => ProductProfilView(
            'assets/image/yaka/${index + 1}.png',
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: removeFavButton
                ? SizedBox(
                    width: Get.size.width,
                    child: ClipRRect(
                      borderRadius: borderRadius10,
                      child: Image.asset(
                        'assets/image/yaka/${index + 1}.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: borderRadius10,
                          child: Image.asset(
                            'assets/image/yaka/${index + 1}.png',
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
          ),
          Padding(
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
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: downloadable
                      ? const DownloadButton()
                      : const Text(
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
          ),
        ],
      ),
    );
  }
}
