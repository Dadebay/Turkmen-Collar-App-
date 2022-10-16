import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/data/models/banner_model.dart';

class BannerService {
  Future<List<BannerModel>> getBanners() async {
    final List<BannerModel> bannerList = [];
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/banners/',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      for (final Map product in responseJson) {
        bannerList.add(BannerModel.fromJson(product));
      }
      return bannerList;
    } else {
      return [];
    }
  }
}
