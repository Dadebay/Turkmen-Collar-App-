import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignInPageController extends GetxController {
  final storage = GetStorage();
  RxBool agreeButton = false.obs;
  dynamic saveUserName(String userName, String sureName) {
    storage.write('userName', userName);
    storage.write('sureName', sureName);
  }
}
