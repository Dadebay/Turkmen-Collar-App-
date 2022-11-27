import 'dart:convert';
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
    final List<dynamic> categoryList = [];
    homeController.loading.value = 0;
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

      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      if (CategoryModel.fromJson(responseJson).isCollar ?? false) {
        for (final Map product in responseJson['collars']['data']) {
          categoryList.add(CollarModel.fromJson(product));
        }
      } else {
        for (final Map product in responseJson['products']['data']) {
          categoryList.add(DressesModel.fromJson(product));
        }
      }
      return categoryList;
    } else {
      homeController.loading.value = 1;

      return [];
    }
  }
}
