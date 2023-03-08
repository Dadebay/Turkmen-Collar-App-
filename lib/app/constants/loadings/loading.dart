import 'package:flutter/material.dart';

import '../constants.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: kPrimaryColor,
      ),
    );
  }
}
