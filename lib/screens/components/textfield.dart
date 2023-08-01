import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';

import 'getx.dart';


// ignore: must_be_immutable
class MyTextFormField extends StatelessWidget {
  final String fieldName;
  bool? isPassword;
  Function? onSave;
  final String formName;

  MyTextFormField(
      {super.key,
      required this.fieldName,
      this.isPassword,
      this.onSave,
      required this.formName});

  TextEditingController controller_ = TextEditingController();
  FromConroller gList = Get.put(FromConroller());
  UserController userController = UserController();

  save_(value) {
    if (formName == 'login') {
      gList.loginInputList.add(value);
      if (gList.loginInputList.length == 2) {
        gList.loginInputList
            .add(gList.userType.value); // add user type into the list getx
        userController.loginContoller(gList.loginInputList);
        gList.loginInputList.clear();
        print('cleared');
      }
    } else if (formName == 'customer') {
      gList.customerInputList.add(value);
      if (gList.customerInputList.length == 4) {
        userController.customerRegisterController(gList.customerInputList);
        gList.customerInputList.clear();
      }
    } else if (formName == 'shop') {
      gList.shopInputList.add(value);
      if (gList.shopInputList.length == 4) {
        userController.shopRegisterController(gList.shopInputList);
        gList.shopInputList.clear();
      }
    } else if (formName == 'addfood') {
      gList.foodInputList.add(value);
      print(gList.foodInputList);
      if (gList.foodInputList.length == 2) {
        print(gList.foodInputList);
      }
    } else {
      print('invalid formName');
    }

    if (gList.loginInputList.length == 2) {
      gList.loginInputList.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        style: const TextStyle(fontSize: 18),
        obscureText: isPassword ?? false,
        decoration: InputDecoration(
          errorMaxLines: 1,
          filled: true,
          fillColor: Colors.white,
          hintText: fieldName,
          hintStyle: const TextStyle(fontSize: 18),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'field cannot be empty';
          }
          return null;
        },
        onSaved: (newValue) => save_(newValue),
      ),
    );
  }
}
