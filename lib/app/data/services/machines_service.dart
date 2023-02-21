import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/data/models/clothes_model.dart';
import 'package:yaka2/app/data/models/machines_model.dart';

import 'auth_service.dart';

class MachineService {
  Future<List<MachineModel>> getMachines() async {
    final token = await Auth().getToken();

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
      final responseJson = json.decode(response.body);
      print(responseJson);
      for (final Map product in responseJson['data']) {
        machineList.add(MachineModel.fromJson(product));
      }

      return machineList;
    } else {
      return [];
    }
  }

  Future<DressesModelByID> getMachineByID(int id) async {
    final token = await Auth().getToken();

    final response = await http.get(
      Uri.parse(
        '$serverURL/api/v1/products/$id',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return DressesModelByID.fromJson(responseJson);
    } else {
      return DressesModelByID();
    }
  }
}
