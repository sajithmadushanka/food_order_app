import 'package:eatme/screens/shop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../assets/fonts.dart';
import '../colors.dart';
import '../utils/firebase.dart';
import 'components/getx.dart';

class CustomerDashboard extends StatefulWidget {
  final String username;
  const CustomerDashboard({Key? key, required this.username}) : super(key: key);

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  @override
  void initState() {
    readAllShop();
    super.initState();
  }

  FromConroller gex = Get.put(FromConroller());
  void readAllShop() async {
    Authentication auth_ = Authentication();
    await auth_.readAllShopData();
    FromConroller gex = Get.put(FromConroller());
    print(gex.shopList[0].shopname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
          backgroundColor: btnColor,
          leading: const Icon(Icons.settings),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Good Morning', style: TextStyle(fontSize: 20)),
              Text(widget.username, style: const TextStyle(fontSize: 20))
            ],
          )),
      body: Obx(
        () => ListView.builder(
          itemCount: gex.shopList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Get.to(ShopScreen(
                  shopName: gex.shopList[index].shopname,
                  shopId: gex.shopList[index].shopId)),
              child: Container(
                height: 100,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.2),
                          BlendMode.darken,
                        ),
                        child: const SizedBox.expand(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('lib/assets/images/1.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          gex.shopList[index].shopname,
                          style: MyFont(fontsize: 20, color_: Colors.white)
                              .getMainFont(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
