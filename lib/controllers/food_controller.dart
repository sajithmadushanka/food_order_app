import 'package:eatme/utils/firebase.dart';
import '../models/food_model.dart';

class FoodController {
  final Authentication _auth = Authentication();
  void addFood(String shopid, String name, String price, String url) {
    Food food =
        Food(shopId: shopid, foodName: name, foodPrice: price, foodImgUrl: url);
    _auth.addFood(food);
  }
}
