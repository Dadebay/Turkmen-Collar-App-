import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';

import 'auth_service.dart';

class SignInService {
  Future otpCheck({
    String? otp,
    String? phoneNumber,
  }) async {
    final response = await http.post(
      Uri.parse('$serverURL/api/v1/login/verify'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'otp': otp,
        'phone': phoneNumber,
      }),
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      await Auth().setToken(responseJson['data']['api_token']);
      Get.find<HomeController>().balance.value = "${responseJson['data']['balance']}";
      return true;
    } else {
      return response.statusCode;
    }
  }

  Future login({required String phone}) async {
    final response = await http.post(
      Uri.parse('$serverURL/api/v1/login'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone': phone,
      }),
    );

    return response.statusCode;
  }
}
