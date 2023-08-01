import 'package:eatme/models/customer_model.dart';
import 'package:eatme/models/shop_model.dart';
import 'package:get/get.dart';

import '../screens/components/getx.dart';
import '../utils/firebase.dart';

FromConroller controller = Get.put(FromConroller());
Authentication authentication = Authentication();

class UserController {
  void loginContoller(var list) {
    String userType = list[2];
    var username = list[0];
    var password = list[1];
    if (userType == 'customer') {
      authentication.loginUser(username, password);
    } else if (userType == 'shop') {
      authentication.shopLogin(username, password); 
    } else {
      print('user type error');
    }
  }

  void customerRegisterController(var list) {
    var _customer = Customer(
        username: list[0], email: list[1], password: list[2], coutry: list[3]);
    authentication.cusRegister(_customer);
  }

  void shopRegisterController(var list) {
    var shop = Shop(
        shopname: list[0], email: list[1], password: list[2], coutry: list[3]);
    authentication.shopRegister(shop);
  }
}
