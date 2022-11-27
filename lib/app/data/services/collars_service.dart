import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/data/models/collar_model.dart';

import 'auth_service.dart';

class CollarService {
  Future<List<CollarModel>> getCollars() async {
    final token = await Auth().getToken();

    final List<CollarModel> collarList = [];
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/v1/collars',
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
        collarList.add(CollarModel.fromJson(product));
      }
      return collarList;
    } else {
      return [];
    }
  }

  Future<CollarModel> getCollarsByID(int id) async {
    final token = await Auth().getToken();

    final response = await http.get(
      Uri.parse(
        '$serverURL/api/v1/collars/$id',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);

      return CollarModel.fromJson(responseJson);
    } else {
      return CollarModel();
    }
  }
}
