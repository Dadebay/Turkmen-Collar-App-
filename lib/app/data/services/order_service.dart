import 'dart:_http';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/widgets.dart';

import 'auth_service.dart';

Future createOrder({required List products, required String note, required String customer_name, required String address, required String province, required String phone}) async {
  final token = await Auth().getToken();

  final body = json.encode({'products': products, 'note': note, 'customer_name': customer_name, 'phone': phone, 'address': address, 'province': province});
  final response = await http.post(
    Uri.parse(
      '$serverURL/api/tm/create-order',
    ),
    headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    },
    body: body,
  );
  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    print(responseJson);
    return true;
  } else {
    showSnackBar('retry', 'error404', Colors.red);
    return false;
  }
}
