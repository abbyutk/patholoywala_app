import 'package:pharmacy/ress/model/test.dart';

class CartProduct{

  final int quantity;
  final Test tests;

  CartProduct({required this.quantity, required this.tests});

  static CartProduct fromJson(json,{bool booked = false}){
    return CartProduct(
      quantity: booked ? json['test_quantity'] : json["quantity"]??0,
      tests: booked? Test.fromJson(json) : Test.fromJson(json["product"])
    );
  }

}