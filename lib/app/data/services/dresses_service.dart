import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/data/models/clothes_model.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';

import 'auth_service.dart';

class DressesService {
  final HomeController clothesController = Get.put(HomeController());

  Future<List<DressesModel>> getDresses({required Map<String, dynamic> parametrs}) async {
    final token = await Auth().getToken();

    final List<DressesModel> collarList = [];
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/v1/products',
      ).replace(queryParameters: parametrs),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      clothesController.clothesLoading.value = 2;

      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson['data']) {
        collarList.add(DressesModel.fromJson(product));
      }
      clothesController.clothesLoading.value = 3;

      return collarList;
    } else {
      clothesController.clothesLoading.value = 1;

      return [];
    }
  }


  Future<List<DressesModel>> getGoods({required Map<String, dynamic> parametrs}) async {
    final token = await Auth().getToken();

    final List<DressesModel> collarList = [];
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/v1/sewing-products',
      ).replace(queryParameters: parametrs),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      clothesController.goodsLoading.value = 2;

      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson['data']) {
        collarList.add(DressesModel.fromJson(product));
      }
      clothesController.goodsLoading.value = 3;
      return collarList;
    } else {
      clothesController.goodsLoading.value = 1;
      return [];
    }
  }

  Future<DressesModel> getDressesByID(int id) async {
    final token = await Auth().getToken();

    final response = await http.get(
      Uri.parse(
        '$serverURL/api/v1/products/$id',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      return DressesModel.fromJson(responseJson);
    } else {
      return DressesModel();
    }
  }
}
