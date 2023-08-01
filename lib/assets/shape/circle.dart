import 'package:flutter/material.dart';

import '../../colors.dart';

class MyCircle extends StatelessWidget {
  const MyCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: shapecircle),
    );
  }
}
