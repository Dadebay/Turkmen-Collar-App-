import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yaka2/app/constants/constants.dart';

import 'auth_service.dart';

class FileDownloadService {
  Future downloadFile({required int id}) async {
    final token = await Auth().getToken();
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
    return responseJson['data']['files'];
  }

  Future getAvailabePhoneNumber() async {
    final token = await Auth().getToken();
    final response = await http.get(
      Uri.parse('$serverURL/api/v1/config'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    final responseJson = json.decode(response.body);
    return responseJson;
  }
}
