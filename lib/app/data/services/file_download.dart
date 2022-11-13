import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yaka2/app/constants/constants.dart';

import 'auth_service.dart';

class FileDownload {
  Future downloadFile({required int id}) async {
    final token = await Auth().getToken();
    print(id);
    final response = await http.post(
      Uri.parse('$serverURL/api/v1/users/me/downloads'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'file_id': id,
      }),
    );
    final responseJson = json.decode(response.body);
    print(responseJson['data']['file']);
    print(responseJson);
    print(response.statusCode);
    return responseJson['data']['file'];
  }
}
