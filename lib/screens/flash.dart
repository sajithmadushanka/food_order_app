import 'package:eatme/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

//ignore_for_file: prefer_const_constructors
class FlashScreen extends StatelessWidget {
  const FlashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ColorFiltered(
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
          child: SizedBox.expand(
              child: DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('lib/assets/images/flash _.jpg'),
              fit: BoxFit.cover,
            )),
          )),
        ),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to',
              style: GoogleFonts.aclonica(
                  textStyle: TextStyle(fontSize: 40, color: Colors.white)),
            ),
            Text(
              'EatMe',
              style: GoogleFonts.aclonica(fontSize: 40, color: flashcode_1),
            ),
            SizedBox(height: 100),
            GestureDetector(
              onTap: () {
                Get.to(LoginScreen());
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white),
                child: Image.asset(
                  'lib/assets/images/nextbtn_.png',
                ),
              ),
            )
          ],
        ))
      ],
    ));
  }
}
