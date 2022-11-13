import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/custom_text_field.dart';
import 'package:yaka2/app/constants/phone_number.dart';
import 'package:yaka2/app/constants/widgets.dart';
import 'package:yaka2/app/data/models/about_us_model.dart';
import 'package:yaka2/app/data/services/about_us_service.dart';
import 'package:yaka2/app/others/buttons/agree_button.dart';

class ProfilSettings extends StatefulWidget {
  ProfilSettings({Key? key}) : super(key: key);

  @override
  State<ProfilSettings> createState() => _ProfilSettingsState();
}

class _ProfilSettingsState extends State<ProfilSettings> {
  TextEditingController userNameController = TextEditingController();

  FocusNode userNameFocusNode = FocusNode();

  TextEditingController phoneController = TextEditingController();

  FocusNode phoneFocusNode = FocusNode();

  TextEditingController userSurnameController = TextEditingController();

  FocusNode userSurnameFocusNode = FocusNode();

  String balance = '0.0';

  final storage = GetStorage();

  changeData(String? phone, String? balance) {
    phoneController.text = phone!;
    balance = balance;
  }

  @override
  void initState() {
    super.initState();

    changeUserName();
  }

  changeUserName() async {
    if (storage.read('userName') != null) {
      userNameController.text = await storage.read('userName') ?? 'Yok';
      userSurnameController.text = await storage.read('sureName') ?? 'Yok';
      setState(() {});
    } else {
      userNameController.text = 'Yok';
      userSurnameController.text = 'Yok';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarIconBrightness: Brightness.dark),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            IconlyLight.arrowLeftCircle,
            color: Colors.black,
          ),
        ),
        title: Text(
          'profil'.tr,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<UserMeModel>(
        future: AboutUsService().getuserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (snapshot.hasError) {
            return errorPage(
              onTap: () {
                AboutUsService().getuserData();
              },
            );
            ;
          } else if (snapshot.data == null) {
            return emptyPageImage(
              onTap: () {
                AboutUsService().getuserData();
              },
            );
          }
          changeData(
            snapshot.data!.phone!.substring(4, 12),
            '${snapshot.data!.balance}',
          );
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              textpart('signIn1', false),
              CustomTextField(
                labelName: '',
                controller: userNameController,
                borderRadius: true,
                focusNode: userNameFocusNode,
                requestfocusNode: phoneFocusNode,
                isNumber: false,
                disabled: true,
              ),
              textpart('signIn2', false),
              CustomTextField(
                labelName: '',
                controller: userSurnameController,
                borderRadius: true,
                focusNode: userSurnameFocusNode,
                requestfocusNode: phoneFocusNode,
                isNumber: false,
                disabled: true,
              ),
              textpart('phoneNumber', false),
              PhoneNumber(
                mineFocus: phoneFocusNode,
                controller: phoneController,
                requestFocus: userNameFocusNode,
                style: false,
                disabled: true,
              ),
              textpart('balance', false),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'balance'.tr + ' :',
                      style: TextStyle(fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        balance,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              AgreeButton(
                onTap: () {},
              )
            ],
          );
        },
      ),
    );
  }
}
