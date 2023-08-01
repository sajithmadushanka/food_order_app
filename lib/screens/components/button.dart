import 'package:eatme/colors.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String btnName;
  const MyButton({super.key, required this.btnName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: btnColor, borderRadius: BorderRadius.circular(50.0)),
      child: Center(
          child: Text(
        btnName,
        style: const TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      )),
    );
  }
}
