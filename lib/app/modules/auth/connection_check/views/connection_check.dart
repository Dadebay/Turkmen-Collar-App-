// ignore_for_file: file_names, always_use_package_imports

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yaka2/app/constants/constants.dart';

import '../../../home/views/home_view.dart';

class ConnectionCheckpage extends StatefulWidget {
  const ConnectionCheckpage({super.key});

  @override
  _ConnectionCheckpageState createState() => _ConnectionCheckpageState();
}

class _ConnectionCheckpageState extends State with TickerProviderStateMixin {
  Animation? animation1;

  double _containerOpacity = 0.0;
  int _containerSize = 1;
  late AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3));

    checkConnection();
    Timer(const Duration(seconds: 2), () {
      if (!mounted) {
        return;
      }
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });
  }

  void checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        await Future.delayed(const Duration(seconds: 4), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const HomeView();
                // return ShowAllProductsView(name: 'Yakalar', id: 9);
              },
            ),
          );
        });
      }
    } on SocketException catch (_) {
      _showDialog();
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: const RoundedRectangleBorder(borderRadius: borderRadius20),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
                decoration: const BoxDecoration(color: Colors.white, borderRadius: borderRadius20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'noConnection1'.tr,
                      style: const TextStyle(
                        fontSize: 24.0,
                        color: kPrimaryColor,
                        fontFamily: normsProMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Text(
                        'noConnection2'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: normsProMedium,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          checkConnection();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: borderRadius10,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                      ),
                      child: Text(
                        'noConnection3'.tr,
                        style: const TextStyle(fontSize: 18, color: Colors.white, fontFamily: normsProMedium),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 70,
                minRadius: 60,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/icons/noconnection.gif',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: member-ordering-extended
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                opacity: _containerOpacity,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: Get.size.width / _containerSize,
                  width: Get.size.width / _containerSize,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.asset(
                      logo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const LinearProgressIndicator()
        ],
      ),
    );
  }
}
