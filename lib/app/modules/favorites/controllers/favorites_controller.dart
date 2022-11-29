import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/services/fav_service.dart';

class FavoritesController extends GetxController {
  final RxList favList = [].obs;
  final storage = GetStorage();
  dynamic toggleFav(int id, String name, bool isCollar) async {
    if (favList.isEmpty) {
      favList.add({'id': id, 'name': name});
      if (isCollar == true) {
        await FavService().addCollarToFav(id: id).then((value) {
          if (value == true) {
            showSnackBar('copySucces', 'collarAddToFav', Colors.green);
          } else {
            showSnackBar('noConnection3', 'error', Colors.red);
          }
        });
      } else {
        await FavService().addProductToFav(id: id).then((value) {
          if (value == true) {
            showSnackBar('copySucces', 'productAddToFav', Colors.green);
          } else {
            showSnackBar('noConnection3', 'error', Colors.red);
          }
        });
      }
    } else {
      bool value = false;
      for (final element in favList) {
        if (element['id'] == id) {
          value = true;
        }
      }
      if (value) {
        favList.removeWhere((element) => element['id'] == id);
        if (isCollar == true) {
          await FavService().deleteCollarToFav(id: id).then((value) {
            if (value == true) {
              showSnackBar('copySucces', 'deleteCollar', Colors.red);
            } else {
              showSnackBar('noConnection3', 'error', Colors.red);
            }
          });
        } else {
          await FavService().deleteProductToFav(id: id).then((value) {
            if (value == true) {
              showSnackBar('copySucces', 'deleteProduct', Colors.red);
            } else {
              showSnackBar('noConnection3', 'error', Colors.red);
            }
          });
        }
      } else if (!value) {
        favList.add({'id': id, 'name': name});
        if (isCollar == true) {
          await FavService().addCollarToFav(id: id).then((value) {
            if (value == true) {
              showSnackBar('copySucces', 'collarAddToFav', Colors.green);
            } else {
              showSnackBar('noConnection3', 'error', Colors.red);
            }
          });
        } else {
          await FavService().addProductToFav(id: id).then((value) {
            if (value == true) {
              showSnackBar('copySucces', 'productAddToFav', Colors.green);
            } else {
              showSnackBar('noConnection3', 'error', Colors.red);
            }
          });
        }
      }
    }
    favList.refresh();
    final String jsonString = jsonEncode(favList);
    await storage.write('favList', jsonString);
  }

  dynamic addFavList(int id, String name) {
    bool value = false;
    for (final element in favList) {
      if (element['id'] == id) {
        value = true;
      }
    }
    if (value == true) {
    } else {
      favList.add({'id': id, 'name': name});
    }
  }

  // dynamic returnFavList() {
  //   final result = storage.read('favList') ?? '[]';
  //   final List jsonData = jsonDecode(result);
  //   if (jsonData.isNotEmpty) {
  //     for (final element in jsonData) {
  //       toggleFav(element['id'], element['name']);
  //     }
  //   }
  // }

  dynamic clearFavList() {
    favList.clear();
    final String jsonString = jsonEncode(favList);
    storage.write('favList', jsonString);
  }
}
