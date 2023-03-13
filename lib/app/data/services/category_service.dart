import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/data/models/category_model.dart';
import 'package:yaka2/app/data/models/clothes_model.dart';
import 'package:yaka2/app/data/models/collar_model.dart';

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

  Future<List<dynamic>> getCategoryByID({required int id, required Map<String, String> parametrs}) async {
    final token = await Auth().getToken();
    List<CollarModel> categoryList = [];
    List<DressesModel> productList = [];
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
      final responseJson = json.decode(response.body);
      if (CollarModel.fromJson(responseJson).name == 'Ýakalar') {
        for (final Map product in responseJson['collars']['data']) {
          categoryList.add(CollarModel.fromJson(product));
        }
        return categoryList;
      } else {
        for (final Map product in responseJson['products']['data']) {
          productList.add(DressesModel.fromJson(product));
        }
        return productList;
      }
    } else {
      return [];
    }
  }
}
