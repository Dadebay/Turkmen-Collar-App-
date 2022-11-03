import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/data/models/collar_model.dart';

class DressesService {
  Future<List<CollarModel>> getDresses() async {
    final List<CollarModel> collarList = [];
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/v1/dresses',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      print(responseJson);
      for (final Map product in responseJson['data']) {
        collarList.add(CollarModel.fromJson(product));
      }
      print(collarList);
      return collarList;
    } else {
      return [];
    }
  }
}
