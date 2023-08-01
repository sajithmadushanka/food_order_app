import 'package:eatme/utils/firebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';
import 'components/getx.dart';
import 'components/shop_item_card.dart';

class ShopScreen extends StatefulWidget {
  final String shopName;
  final String shopId;
  const ShopScreen({Key? key, required this.shopName, required this.shopId})
      : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  void initState() {
    readAllFood();
    super.initState();
  }
 FromConroller gex = Get.put(FromConroller());
  void readAllFood() async {
    Authentication _auth = Authentication();
    await _auth.readAllFoodByShopId(widget.shopId);
    FromConroller gex = Get.put(FromConroller());
    print(gex.foodList[0].foodName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: btnColor,
        toolbarHeight: 50,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
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
        ),
        title: Text(widget.shopName,
            style: const TextStyle(fontSize: 20)),
      ),
      body: ListView.builder(
        itemCount: gex.foodList.length,
        itemBuilder: (context, index) {
          return MyShopItemCard(name:gex.foodList[index].foodName, price: gex.foodList[index].foodPrice, url: gex.foodList[index].foodImgUrl);
        },
      ),
    );
  }
}
