import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavoritesController extends GetxController {
  final RxList favList = [].obs;
  final storage = GetStorage();
  dynamic toggleFav(int id, String name) {
    if (favList.isEmpty) {
      favList.add({'id': id, 'name': name});
    } else {
      bool value = false;
      for (final element in favList) {
        if (element['id'] == id) {
          value = true;
        }
      }
      if (value) {
        favList.removeWhere((element) => element['id'] == id);
      } else if (!value) {
        favList.add({'id': id, 'name': name});
      }
    }
    favList.refresh();
    final String jsonString = jsonEncode(favList);
    storage.write('favList', jsonString);
  }

  dynamic returnFavList() {
    final result = storage.read('favList') ?? '[]';
    final List jsonData = jsonDecode(result);
    if (jsonData.isNotEmpty) {
      for (final element in jsonData) {
        toggleFav(element['id'], element['name']);
      }
    }
  }

  dynamic clearFavList() {
    favList.clear();
    final String jsonString = jsonEncode(favList);
    storage.write('favList', jsonString);
  }
}
