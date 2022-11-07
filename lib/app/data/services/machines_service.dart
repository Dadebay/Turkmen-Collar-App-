import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/data/models/machines_model.dart';

class MachineService {
  Future<List<MachineModel>> getMachines() async {
    final List<MachineModel> machineList = [];
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/v1/machines',
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
        machineList.add(MachineModel.fromJson(product));
      }
      return machineList;
    } else {
      return [];
    }
  }

  Future<MachineModel> getMachineByID(int id) async {
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/v1/products/$id',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      return MachineModel.fromJson(responseJson);
    } else {
      return MachineModel();
    }
  }
}
