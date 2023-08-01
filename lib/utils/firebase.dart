import 'package:eatme/screens/customer_dashboard.dart';
import 'package:eatme/screens/shop_dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/customer_model.dart';
import '../models/food_model.dart';
import '../models/shop_model.dart';
import '../screens/components/getx.dart';
import '../screens/login.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestoreInsance = FirebaseFirestore.instance;

  Future<void> loginUser(var username, var password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: username.toString(),
        password: password.toString(),
      );
      if (userCredential.user != null) {
        print(userCredential.user!.uid);
        Customer? cus = await readCusData(userCredential.user!.uid);
        Get.to(CustomerDashboard(username: cus!.username));
      }
    } catch (e) {
      print('Error logging in user: $e');
    }
  }

  // register new user-----------------
  Future<void> cusRegister(Customer cus) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: cus.email, password: cus.password!);
      if (userCredential.user != null) {
        String userId = userCredential.user!.uid;
        await _firestoreInsance.collection('Customer').doc(userId).set({
          'username_': cus.username,
          'email_': cus.email,
          'county_': cus.coutry
        });
        print('registration has successful');
        Get.to(LoginScreen());
      }
    } catch (e) {
      print('Error during registration: $e');
    }

    //----------------------
  }

  Future<Customer?> readCusData(String userId) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestoreInsance.collection('Customer').doc(userId).get();

      if (docSnapshot.exists) {
        Map<String, dynamic> userData =
            docSnapshot.data() as Map<String, dynamic>;
        String username = userData['username_'];
        String email = userData['email_'];
        String county = userData['county_'];

        Customer cus =
            Customer(username: username, email: email, coutry: county);
        return cus;
      } else {
        // The document does not exist
        print('User data not found.');
      }
    } catch (e) {
      print('Error reading user data: $e');
    }
    return null;
  }

  // register new shop -------------------]

  Future<void> shopRegister(Shop shop) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: shop.email, password: shop.password!);
      if (userCredential.user != null) {
        String userId = userCredential.user!.uid;
        await _firestoreInsance.collection('Shop').doc(userId).set({
          'shopid': userId,
          'shopname_': shop.shopname,
          'email_': shop.email,
          'county_': shop.coutry
        });
        print('registration has successful');
        Get.to(LoginScreen());
      }
    } catch (e) {
      print('Error during registration: $e');
    }
  }

  //------------------
  Future<void> shopLogin(var username, var password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: username.toString(),
        password: password.toString(),
      );
      if (userCredential.user != null) {
        print(userCredential.user!.uid);
        var shopId = userCredential.user!.uid;
        var shopdata = await readShopData(shopId);
        if (shopdata != null) {
          Get.to(ShopDashBoardScreen(shop: shopdata, shopid: shopId));
        } else {
          print("shop data null");
        }
      }
    } catch (e) {
      print('Error logging in user: $e');
    }
  }

  /// read shop data
  Future<Shop?> readShopData(String userId) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestoreInsance.collection('Shop').doc(userId).get();

      if (docSnapshot.exists) {
        print('yes exsist');
        Map<String, dynamic> shopData =
            docSnapshot.data() as Map<String, dynamic>;
        String shopname = shopData['shopname_'];
        String email = shopData['email_'];
        String coutry = shopData['county_'];
        Shop shop = Shop(shopname: shopname, email: email, coutry: coutry);
        return shop;
      } else {
        // The document does not exist
        print('Shop data not found.');
      }
    } catch (e) {
      print('Error reading shop data: $e');
    }
    return null;
  }

  Future readAllShopData() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestoreInsance.collection('Shop').get();

      FromConroller getx = Get.put(FromConroller());
      for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
        if (docSnapshot.exists) {
          print('Document exists');
          Map<String, dynamic> shopData =
              docSnapshot.data() as Map<String, dynamic>;

          String shopId = shopData['shopid'] ?? '101';
          String shopname = shopData['shopname_'] ?? 'test name';
          String email = shopData['email_'] ?? 'test email';
          String country = shopData['county_'] ??
              'test country'; // Corrected 'coutry' to 'country'
          Shop shop = Shop(
              shopId: shopId,
              shopname: shopname,
              email: email,
              coutry: country);
          getx.shopList.add(shop);
        } else {
          print('Shop data not found for document ID: ${docSnapshot.id}');
        }
      }
    } catch (e) {
      print('Error reading shop data: $e');
    }
  }

  //---- add new food-----------------
  Future<void> addFood(Food food) async {
    try {
      await _firestoreInsance.collection('Food').doc().set({
        'shopId_': food.shopId,
        'foodName_': food.foodName,
        'foodPrice_': food.foodPrice,
        'foodImgUrl_': food.foodImgUrl
      });
      FromConroller getx = Get.put(FromConroller());
      getx.foodList.add(food);
      print('food has been added');
      Get.back();
    } catch (e) {
      print('food add error');
    }
  }

  // read fooddata
  Future<Food?> readfood(var shopid) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestoreInsance.collection('Food').doc(shopid).get();

      if (docSnapshot.exists) {
        print('yes exsist');
        Map<String, dynamic> foodData =
            docSnapshot.data() as Map<String, dynamic>;
        String foodname = foodData['foodName_'];
        String foodprice = foodData['foodPrice_'];
        String url = foodData['foodImgUrl_'];
        Food food = Food(
            foodName: foodname,
            foodPrice: foodprice,
            foodImgUrl: url,
            shopId: shopid);
        return food;
      } else {
        // The document does not exist
        print('Shop data not found.');
      }
    } catch (e) {
      print('Error reading shop data: $e');
    }
    return null;
  }

  Future readAllFoodByShopId(String shopid) async {
    print(shopid);
    try {
      QuerySnapshot querySnapshot = await _firestoreInsance
          .collection('Food')
          .where('shopId_', isEqualTo: shopid)
          .get();

      FromConroller getx = Get.put(FromConroller());

      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        if (docSnapshot.exists) {
          print('Document exists');
          Map<String, dynamic> foodData =
              docSnapshot.data() as Map<String, dynamic>;
          String foodname = foodData['foodName_'];
          String foodprice = foodData['foodPrice_'];
          String url = foodData['foodImgUrl_'];
          Food food = Food(
            foodName: foodname,
            foodPrice: foodprice,
            foodImgUrl: url,
            shopId: shopid,
          );
          getx.foodList.add(food);
        } else {
          // Handle the case where a document does not exist
          print('Food data not found for shop ID: $shopid');
        }
      }
    } catch (e) {
      print('Error reading food data: $e');
    }
  }
}
