import 'package:eatme/colors.dart';
import 'package:eatme/screens/components/button.dart';
import 'package:eatme/screens/components/textfield.dart';
import 'package:eatme/screens/login.dart';
import 'package:eatme/screens/shop_re_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../assets/fonts.dart';
import 'components/shape_position.dart';

//ignore_for_file: prefer_const_constructors
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Stack(
        children: [
          MyShapePostion(
              alignment: Alignment.topLeft, xOffset: -40, yOffset: -40),
          MyShapePostion(
              alignment: Alignment.bottomRight, xOffset: 40, yOffset: 40),
          // input fields----------------------
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Customer Registration',
                  style: MyFont(fontsize: 22).getMainFont(),
                ),
                SizedBox(height: 20.0),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        MyTextFormField(
                            fieldName: 'Enter username', formName: 'customer'),
                        MyTextFormField(
                            fieldName: 'Enter email', formName: 'customer'),
                        MyTextFormField(
                            fieldName: 'Enter password',
                            isPassword: true,
                            formName: 'customer'),
                        MyTextFormField(
                            fieldName: 'Enter country', formName: 'customer'),
                        SizedBox(height: 20.0),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                            } else {
                              print('wrong');
                            }
                          },
                          child: MyButton(btnName: 'SUBMIT'),
                        )
                      ],
                    )),
                SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    Get.to(LoginScreen());
                  },
                  child: Text(
                    'I have an account',
                    style: TextStyle(fontSize: 17, color: linkColor),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Get.to(ShopRegister());
                  },
                  child: MyButton(btnName: 'Shop Register'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
