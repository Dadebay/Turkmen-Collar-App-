import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:yaka2/app/constants/constants.dart';

class FavButton extends StatefulWidget {
  const FavButton({super.key});

  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          value = !value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          borderRadius: borderRadius15,
          color: Colors.white,
        ),
        child: Icon(
          value ? IconlyBold.heart : IconlyLight.heart,
          color: value ? Colors.red : Colors.black,
          size: 28,
        ),
      ),
    );
  }
}
