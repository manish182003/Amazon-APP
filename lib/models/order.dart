import 'dart:convert';

import 'package:amazon_app/models/product.dart';

class order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final double totalPrice;
  final String userid;
  final int orderat;
  final int status;

  order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.totalPrice,
    required this.userid,
    required this.orderat,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userid': userid,
      'orderat': orderat,
      'status': status,
      'totalPrice': totalPrice,
    };
  }

  factory order.fromMap(Map<String, dynamic> map) {
    return order(
        id: map['_id'] ?? '',
        products: List<Product>.from(
            map['products']?.map((x) => Product.fromMap(x['product']))),
        quantity: List<int>.from(map['products']?.map((x) => x['quantity'])),
        address: map['address'] ?? '',
        userid: map['userid'] ?? '',
        orderat: map['orderat']?.toInt() ?? 0,
        status: map['status']?.toInt() ?? 0,
        totalPrice: map['totalPrice']?.toDouble() ?? 0.0);
  }

  String toJson() => json.encode(toMap());

  factory order.fromJson(String source) => order.fromMap(json.decode(source));
}
