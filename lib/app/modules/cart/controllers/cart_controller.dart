import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  RxList list = [].obs;
  final storage = GetStorage();
  void addToCard(int id) {
    if (list.isEmpty) {
      list.add({'id': id, 'quantity': 1});
    } else {
      bool value = false;
      for (final element in list) {
        if (element['id'] == id) {
          element['quantity'] += 1;
          value = true;
        }
      }
      if (value == false) {
        list.add({'id': id, 'quantity': 1});
      }
      list.refresh();
      final String jsonString = jsonEncode(list);
      storage.write('cartList', jsonString);
      print(list);
    }
  }

  void minusCardElement(int id) {
    for (final element in list) {
      if (element['id'] == id) {
        element['quantity'] -= 1;
      }
    }
    list.removeWhere((element) => element['quantity'] == 0);
    list.refresh();
    final String jsonString = jsonEncode(list);
    storage.write('cartList', jsonString);
    print(list);
  }

  void xbuttonRemoveCart(int id) {
    list.removeWhere((element) => element['id'] == id);
    list.refresh();
    final String jsonString = jsonEncode(list);
    storage.write('cartList', jsonString);
  }
}
