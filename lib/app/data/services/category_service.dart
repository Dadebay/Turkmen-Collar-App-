import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/data/models/category_model.dart';
import 'package:yaka2/app/data/models/clothes_model.dart';
import 'package:yaka2/app/data/models/collar_model.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';

import 'auth_service.dart';

class CategoryService {
  Future<List<CategoryModel>> getCategories() async {
    final token = await Auth().getToken();

    final List<CategoryModel> categoryList = [];
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/v1/categories',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson['data']) {
        categoryList.add(CategoryModel.fromJson(product));
      }
      return categoryList;
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getCategoryByID(int id, {required Map<String, dynamic> parametrs}) async {
    final token = await Auth().getToken();
    final HomeController homeController = Get.put(HomeController());
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/v1/categories/$id',
      ).replace(queryParameters: parametrs),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      homeController.loading.value = 3;

      final responseJson = json.decode(response.body);
      if (CategoryModel.fromJson(responseJson).name == 'Ýakalar') {
        for (final Map product in responseJson['collars']['data']) {
          log('$product');
          homeController.showAllList.add({
            'id': CollarModel.fromJson(product).id,
            'name': CollarModel.fromJson(product).name,
            'price': CollarModel.fromJson(product).price,
            'createdAt': CollarModel.fromJson(product).createdAt,
            'images': CollarModel.fromJson(product).image,
          });
        }
      } else {
        for (final Map product in responseJson['products']['data']) {
          homeController.showAllList.add({
            'id': DressesModel.fromJson(product).id,
            'name': DressesModel.fromJson(product).name,
            'price': DressesModel.fromJson(product).price,
            'createdAt': DressesModel.fromJson(product).createdAt,
            'images': DressesModel.fromJson(product).image,
            'files': [],
          });
        }
      }
      return homeController.showAllList;
    } else {
      homeController.loading.value = 1;
      return [];
    }
  }
}
