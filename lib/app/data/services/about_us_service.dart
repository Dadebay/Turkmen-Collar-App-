import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/data/models/about_us_model.dart';

import 'auth_service.dart';

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

  Future<List<FAQModel>> getFAQ() async {
    final List<FAQModel> faqList = [];

    final response = await http.get(
      Uri.parse(
        '$serverURL/api/v1/faqs',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson['data']) {
        faqList.add(FAQModel.fromJson(product));
      }
      return faqList;
    } else {
      return [];
    }
  }

  Future<UserMeModel> getuserData() async {
    final token = await Auth().getToken();
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/v1/users/me',
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
      return UserMeModel.fromJson(responseJson);
    } else {
      return UserMeModel();
    }
  }

  Future<List<GetMachinesModel>> getmMchines() async {
    final List<GetMachinesModel> machinesList = [];

    final response = await http.get(
      Uri.parse(
        '$serverURL/api/v1/sort/machines',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson['data']) {
        machinesList.add(GetMachinesModel.fromJson(product));
      }
      return machinesList;
    } else {
      return [];
    }
  }
}
