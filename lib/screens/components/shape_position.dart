import 'package:flutter/material.dart';

import '../../assets/shape/circle.dart';

class MyShapePostion extends StatelessWidget {
  final Alignment alignment;
  final double xOffset;
  final double yOffset;
  const MyShapePostion({super.key, required this.alignment, required this.xOffset, required this.yOffset});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:alignment,
      child: Transform.translate(
        offset: Offset(xOffset, yOffset),
        child: const MyCircle(),
      ),
    );
  }
}
