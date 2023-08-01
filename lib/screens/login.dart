import 'package:eatme/assets/fonts.dart';
import 'package:eatme/colors.dart';
import 'package:eatme/screens/components/button.dart';
import 'package:eatme/screens/components/getx.dart';
import 'package:eatme/screens/components/textfield.dart';
import 'package:eatme/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/shape_position.dart';

//ignore_for_file: prefer_const_constructors
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  FromConroller conroller_ = Get.put(FromConroller());

  void onSave() {
    print('onsave');
    print(conroller_.loginInputList);
  }

// redio button -------------

  void rediobtn(String? value) {
    print(value);

    conroller_.userType.value = value!;
    print("this ${conroller_.userType.value}");
  }

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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LOGIN',
                    style: MyFont(fontsize: 22).getMainFont(),
                  ),
                  Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RadioListTile(
                          title: Text('Customer'),
                          onChanged: (value) {
                            conroller_.userType.value = value!;
                            print(conroller_.userType.value);
                          },
                          value: 'customer',
                          groupValue: conroller_.userType.value,
                        ),
                        RadioListTile(
                          title: Text('Shop'),
                          onChanged: (value) {
                            conroller_.userType.value = value!;
                            print(conroller_.userType.value);
                          },
                          value: 'shop',
                          groupValue: conroller_.userType.value,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          MyTextFormField(
                              fieldName: 'Enter email',
                              onSave: onSave,
                              formName: 'login'),
                          MyTextFormField(
                              fieldName: 'Enter password',
                              isPassword: true,
                              formName: 'login'),
                          SizedBox(height: 20.0),
                          // login button --------------------
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                              }
                              print('clicked');
                            },
                            child: MyButton(btnName: 'LOGIN'),
                          )
                        ],
                      )),
                  SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      Get.to(RegisterScreen());
                    },
                    child: Text(
                      'I don\'t have an account',
                      style: TextStyle(fontSize: 17, color: linkColor),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
