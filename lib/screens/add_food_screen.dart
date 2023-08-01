import 'package:eatme/assets/fonts.dart';
import 'package:eatme/colors.dart';
import 'package:eatme/controllers/food_controller.dart';
import 'package:eatme/screens/components/button.dart';
import 'package:eatme/screens/components/textfield.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../models/shop_model.dart';
import 'components/getx.dart';

class AddFoodScreen extends StatefulWidget {
  final String shopId;
  final Shop shop;
  const AddFoodScreen({super.key, required this.shopId, required this.shop});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final _formKey = GlobalKey<FormState>();

  // image picker---------------------
  XFile? _pickedImage;
  bool isLoading = false;
  // Get image from gallery
  var image;
  Future _getFromGallery() async {
    setState(() {
      isLoading = true;
    });
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = image;
      isLoading = false;
    });
  }

  // Import the dart:io library to use the File class.

  // XFile? _pickedImage;
  // bool isLoading = false;
  String _imageUrl = '';
  Future<void> _uploadImage() async {
    if (image != null) {
      final File file = File(image.path); // Convert XFile to File here.
      final Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
              'images/' + image.name + DateTime.now().microsecond.toString());
      await ref.putFile(file); // Use the File object instead of XFile.
      print('image uploaded successfull');
      _imageUrl = await ref.getDownloadURL();
      FoodController foodController = FoodController();
      FromConroller gList = Get.put(FromConroller());
      // add into food controller
      print(widget.shopId);
      foodController.addFood(widget.shopId, gList.foodInputList[0],
          gList.foodInputList[1], _imageUrl);
    } else {
      print('null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        toolbarHeight: 50,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 30,
              maxHeight: 30,
            ),
            child: Image.asset('lib/assets/images/backbtn.png',
                fit: BoxFit.contain),
          ),
        ),
        title: Text('Add new food',
            style: MyFont(fontsize: 20, color_: Colors.white).getMainFont()),
        backgroundColor: btnColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // input fields----------------------
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30.0),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            MyTextFormField(
                                fieldName: 'food name', formName: 'addfood'),
                            MyTextFormField(
                                fieldName: 'price', formName: 'addfood'),

                            // image show -----------------------
                            Container(
                              height: 200,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 214, 214, 213),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: isLoading
                                    ? const CircularProgressIndicator.adaptive()
                                    : _pickedImage == null
                                        ? GestureDetector(
                                            onTap: _getFromGallery,
                                            child: const Text('selecte Image'))
                                        : Image.file(File(_pickedImage!.path)),
                              ),
                            ),

                            const SizedBox(height: 20.0),
                            // login button --------------------
                            GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    _uploadImage();

                                    print('validated');
                                  }
                                  print('clicked');
                                },
                                child: const MyButton(btnName: 'ADD')),
                          ],
                        )),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
