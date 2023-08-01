class Customer {
  final String username;
  final String email;
  String? password;
  final String coutry;
  Customer(
      {required this.username,
      required this.email,
       this.password,
      required this.coutry});
      
}
