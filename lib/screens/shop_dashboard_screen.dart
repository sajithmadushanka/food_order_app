import 'package:eatme/screens/add_food_screen.dart';
import 'package:eatme/utils/firebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';
import '../models/shop_model.dart';
import 'components/getx.dart';
import 'components/shop_item_card.dart';

class ShopDashBoardScreen extends StatefulWidget {
  final Shop shop;
  final String shopid;
  const ShopDashBoardScreen(
      {Key? key, required this.shop, required this.shopid})
      : super(key: key);

  @override
  State<ShopDashBoardScreen> createState() => _ShopDashBoardScreenState();
}

class _ShopDashBoardScreenState extends State<ShopDashBoardScreen> {
  @override
  void initState() {
    readAllFood();
    super.initState();
  }

  FromConroller gex = Get.put(FromConroller());
  void readAllFood() async {
    Authentication auth = Authentication();
    await auth.readAllFoodByShopId(widget.shopid);
   
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
          title: Text('Good Morning ${widget.shop.shopname}',
              style: const TextStyle(fontSize: 20)),
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: gex.foodList.length,
            itemBuilder: (context, index) {
              return MyShopItemCard(
                  name: gex.foodList[index].foodName,
                  price: gex.foodList[index].foodPrice,
                  url: gex.foodList[index].foodImgUrl);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddFoodScreen(shopId: widget.shopid, shop: widget.shop));
          },
          backgroundColor: btnColor,
          child: const Center(
              child: Text('+',
                  style: TextStyle(fontSize: 30, color: Colors.white))),
        ));
  }
}
