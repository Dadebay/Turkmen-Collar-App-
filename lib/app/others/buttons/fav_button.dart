import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/services/auth_service.dart';
import 'package:yaka2/app/modules/favorites/controllers/favorites_controller.dart';

class FavButton extends StatefulWidget {
  const FavButton({required this.whcihPage, required this.isCollar, required this.id, required this.name});
  final bool isCollar;
  final bool whcihPage;
  final int id;
  final String name;
  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  bool value = false;
  final FavoritesController favoritesController = Get.put(FavoritesController());
  @override
  void initState() {
    super.initState();
    work();
  }

  dynamic work() {
    for (var element in favoritesController.favList) {
      if (element['id'] == widget.id && element['name'] == widget.name) {
        value = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      work();

      return GestureDetector(
        onTap: () async {
          final token = await Auth().getToken();
          print(token);
          if (token == null || token == '') {
            showSnackBar('loginError', 'loginErrorSubtitle1', Colors.red);
          } else {
            print(widget.isCollar);
            if (widget.isCollar == true) {
              setState(() {
                value = !value;
                favoritesController.toggleFav(widget.id, widget.name, widget.isCollar);
              });
            }
            if (widget.isCollar == false) {
              setState(() {
                value = !value;
                favoritesController.toggleFav(widget.id, widget.name, widget.isCollar);
              });
            }
          }
          print(favoritesController.favList);
        },
        child: Container(
          padding: EdgeInsets.all(widget.whcihPage ? 8 : 6),
          decoration: BoxDecoration(
            borderRadius: widget.whcihPage ? borderRadius15 : borderRadius10,
            color: Colors.white,
          ),
          child: Icon(
            value ? IconlyBold.heart : IconlyLight.heart,
            color: value ? Colors.red : Colors.black,
            size: widget.whcihPage ? 28 : 22,
          ),
        ),
      );
    });
  }
}
