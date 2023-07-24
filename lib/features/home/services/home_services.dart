import 'dart:convert';
import 'package:amazon_app/constants/error%20handling.dart';
import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/constants/utils.dart';
import 'package:amazon_app/models/product.dart';
import 'package:amazon_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class homeservices {
  Future<List<Product>> fetchcategoryproducts({
    required BuildContext context,
    required String Category,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productlist = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products?category=$Category'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.token,
        },
      );
      httperrorhandle(
          response: res,
          context: context,
          onsuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productlist.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showsnackbar(context, e.toString());
    }
    return productlist;
  }

  Future<Product> fetchDealOfTheDay({
    required BuildContext context,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;
    Product product = Product(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/deal-of-day'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.token,
        },
      );
      httperrorhandle(
        response: res,
        context: context,
        onsuccess: () {
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      showsnackbar(context, e.toString());
    }
    return product;
  }
}
