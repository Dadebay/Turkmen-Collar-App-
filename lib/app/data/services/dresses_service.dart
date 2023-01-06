import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/data/models/clothes_model.dart';

import 'auth_service.dart';

class DressesService {
  Future<List<DressesModel>> getDresses() async {
    final token = await Auth().getToken();

    final List<DressesModel> collarList = [];
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/v1/products',
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
        collarList.add(DressesModel.fromJson(product));
      }
      return collarList;
    } else {
      return [];
    }
  }

  Future<List<DressesModel>> getGoods() async {
    final token = await Auth().getToken();

    final List<DressesModel> collarList = [];
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/v1/sewing-products',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    log(response.body);
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson['data']) {
        collarList.add(DressesModel.fromJson(product));
      }
      return collarList;
    } else {
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
