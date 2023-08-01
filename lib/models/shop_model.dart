class Shop {
  String? shopId;
  final String shopname;
  final String email;
  String? password;
  final String coutry;
  Shop(
      {required this.shopname,
      required this.email,
      this.password,
      required this.coutry, this.shopId});
  @override
  String toString() {
    return 'Shop: { shopname: $shopname, email: $email, country: $coutry , shopId:$shopId}';
  }
}
