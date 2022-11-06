import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/data/models/about_us_model.dart';

class AboutUsService {
  Future<AboutUsModel> getAboutUs() async {
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/v1/about/',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      return AboutUsModel.fromJson(responseJson);
    } else {
      return AboutUsModel();
    }
  }
}
