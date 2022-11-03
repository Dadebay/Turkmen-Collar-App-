import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yaka2/app/data/models/banner_model.dart';
import 'package:yaka2/app/data/models/category_model.dart';
import 'package:yaka2/app/data/models/collar_model.dart';
import 'package:yaka2/app/data/models/machines_model.dart';
import 'package:yaka2/app/data/services/banner_service.dart';
import 'package:yaka2/app/data/services/category_service.dart';
import 'package:yaka2/app/data/services/collars_service.dart';
import 'package:yaka2/app/data/services/dresses_service.dart';
import 'package:yaka2/app/data/services/machines_service.dart';

class HomeController extends GetxController {
  RxInt bannerDotsIndex = 0.obs;
  RxBool agreeButton = false.obs;
  final RxList favList = [].obs;
  final storage = GetStorage();
  late final Future<List<BannerModel>> future;
  late final Future<List<CategoryModel>> category;
  late final Future<List<CollarModel>> collars;
  late final Future<List<CollarModel>> dresses;
  late final Future<List<MachineModel>> machines;
  dynamic toggleFav(int id) {
    print(favList);
    if (favList.isEmpty) {
      favList.add({'id': id});
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
        favList.add({'id': id});
      }
    }
    favList.refresh();
    final String jsonString = jsonEncode(favList);
    storage.write('favList', jsonString);
    print(favList);
  }

  dynamic returnFavList() {
    final result = storage.read('favList') ?? '[]';
    final List jsonData = jsonDecode(result);
    if (jsonData.isNotEmpty) {
      for (final element in jsonData) {
        toggleFav(element['id']);
      }
    }
  }

  dynamic clearFavList() {
    favList.clear();
    final String jsonString = jsonEncode(favList);
    storage.write('favList', jsonString);
  }

  @override
  void onInit() {
    super.onInit();
    future = BannerService().getBanners();
    category = CategoryService().getCategories();
    collars = CollarService().getCollars();
    dresses = DressesService().getDresses();
    machines = MachineService().getMachines();
  }
}
