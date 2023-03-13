import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/services/fav_service.dart';

class FavoritesController extends GetxController {
  final RxList favList = [].obs;
  final storage = GetStorage();

  dynamic addCollarFavList(int id, String name) async {
    await FavService().addCollarToFav(id: id).then((value) {
      if (value == 201) {
        showSnackBar('copySucces', 'collarAddToFav', Colors.green);
        favList.add({'id': id, 'name': name});
      } else {
        showSnackBar('noConnection3', 'error', Colors.red);
      }
    });
    print(favList);
    favList.refresh();
    final String jsonString = jsonEncode(favList);
    await storage.write('favList', jsonString);
  }

  dynamic removeCollarFavList(int id) async {
    await FavService().deleteCollarToFav(id: id).then((value) {
      if (value == 204) {
        favList.removeWhere((element) => element['id'] == id);
        showSnackBar('copySucces', 'deleteCollar', Colors.red);
      } else {
        showSnackBar('noConnection3', 'error', Colors.red);
      }
    });
    favList.refresh();
    final String jsonString = jsonEncode(favList);
    await storage.write('favList', jsonString);
  }

////////////////////////////////////////////////////////////
  dynamic addProductFavList(int id, String name) async {
    await FavService().addProductToFav(id: id).then((value) {
      if (value == 201) {
        showSnackBar('copySucces', 'productAddToFav', Colors.green);
        favList.add({'id': id, 'name': name});
      } else {
        showSnackBar('noConnection3', 'error', Colors.red);
      }
    });
    favList.refresh();
    final String jsonString = jsonEncode(favList);
    await storage.write('favList', jsonString);
  }

  dynamic removeProductFavList(int id) async {
    await FavService().deleteProductToFav(id: id).then((value) {
      if (value == 204) {
        favList.removeWhere((element) => element['id'] == id);
        showSnackBar('copySucces', 'deleteProduct', Colors.red);
      } else {
        showSnackBar('noConnection3', 'error', Colors.red);
      }
    });
    favList.refresh();
    final String jsonString = jsonEncode(favList);
    await storage.write('favList', jsonString);
  }

  dynamic clearFavList() {
    favList.clear();
    final String jsonString = jsonEncode(favList);
    storage.write('favList', jsonString);
  }
}
