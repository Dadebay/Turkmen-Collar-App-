import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:yaka2/app/constants/constants.dart';

import 'auth_service.dart';

class OrderService {
  Future createOrder({required List products, required String note, required String customer_name, required String address, required String province, required String phone}) async {
    final token = await Auth().getToken();

    final headers = {
      'Authorization': 'Bearer $token',
    };
    print(token);
    final request = http.MultipartRequest('POST', Uri.parse('$serverURL/api/v1/users/me/orders'));
    request.fields.addAll({'products': jsonEncode(products), 'note': note, 'customer_name': customer_name, 'address': address, 'phone': '993${phone}', 'province': province});

    request.headers.addAll(headers);

    final http.StreamedResponse response = await request.send();
    print(response.stream);
    print(response.statusCode);
    if (response.statusCode == 201) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
}
