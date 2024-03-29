import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/error_state/no_image.dart';
import 'package:yaka2/app/data/models/machines_model.dart';
import 'package:yaka2/app/others/buttons/add_cart_button.dart';

import '../../constants/loadings/loading.dart';
import '../product_profil/views/machines_product_profil.dart';

class MachineCard extends StatelessWidget {
  final MachineModel model;

  MachineCard({
    required this.model,
    Key? key,
  }) : super(key: key);
  double a = 0.0;
  double b = 0.0;
  @override
  Widget build(BuildContext context) {
    a = double.parse(model.price.toString());
    b = a / 100.0;
    return Container(
      width: Get.size.width / 1.2,
      margin: const EdgeInsets.only(left: 15, bottom: 5),
      child: ElevatedButton(
        onPressed: () {
          Get.to(
            () => MachinesProductProfil(
              id: model.id!,
              image: model.images!,
              name: model.name!,
              createdAt: model.createdAt!,
              price: '$b',
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          elevation: 0.5,
          backgroundColor: kPrimaryColorCard,
          shape: const RoundedRectangleBorder(borderRadius: borderRadius10),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Positioned.fill(
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
                        child: OptimizedCacheImage(
                          fadeInCurve: Curves.ease,
                          imageUrl: model.images!,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: borderRadius10,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Loading(),
                          errorWidget: (context, url, error) => NoImage(),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    right: 8,
                    child: Image.asset(
                      logo1,
                      width: 50,
                      height: 20,
                    ),
                  ),
                ],
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
                    Text(
                      model.name!,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black, fontSize: 19),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '$b',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 21,
                              fontFamily: normProBold,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              ' TMT',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontFamily: normsProMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      model.createdAt!,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: normsProRegular,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: AddCartButton(
                        id: model.id!,
                        price: '${model.price!}',
                        productProfil: false,
                        createdAt: model.createdAt!,
                        image: model.images!,
                        name: model.name!,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
