class Food {
  final String shopId;
  final String foodName;
  final String foodPrice;
  final String foodImgUrl;
  Food(
      {required this.shopId,
      required this.foodName,
      required this.foodPrice,
      required this.foodImgUrl});

  @override
  String toString() {
    return 'Food: { foodname: $foodName, foodprice: $foodPrice, url: $foodImgUrl}';
  }
}
