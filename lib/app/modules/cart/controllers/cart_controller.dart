import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  RxList list = [].obs;
  final storage = GetStorage();
  void addToCard({required int id, required String image, required String name, required String price, required String createdAT}) {
    if (list.isEmpty) {
      list.add({'id': id, 'name': name, 'image': image, 'price': price, 'createdAt': createdAT, 'quantity': 1});
    } else {
      bool value = false;
      for (final element in list) {
        if (element['id'] == id) {
          element['quantity'] += 1;
          value = true;
        }
      }
      if (!value) {
        list.add({'id': id, 'name': name, 'image': image, 'price': price, 'createdAt': createdAT, 'quantity': 1});
      }
      list.refresh();
      final String jsonString = jsonEncode(list);
      storage.write('cartList', jsonString);
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
  }

  dynamic returnCartList() {
    final result = storage.read('cartList') ?? '[]';
    final List jsonData = jsonDecode(result);
    if (jsonData.isEmpty) {
    } else {
      for (final element in jsonData) {
        list.add({
          'id': element['id'],
          'name': element['name'],
          'image': element['image'],
          'price': element['price'],
          'createdAt': element['createdAt'],
          'quantity': element['quantity'],
        });
      }
    }
  }

  void removeAllCartElements() {
    list.clear();
    final String jsonString = jsonEncode(list);
    storage.write('cartList', jsonString);
  }
}
