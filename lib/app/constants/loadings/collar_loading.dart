import 'package:flutter/material.dart';

import '../constants.dart';
import 'loading.dart';

class CollarLoading extends StatelessWidget {
  const CollarLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: const BoxDecoration(borderRadius: borderRadius10, color: kGreyColor),
          width: 180,
          margin: const EdgeInsets.only(left: 15, bottom: 5),
          child: Loading(),
        );
      },
    );
  }
}
