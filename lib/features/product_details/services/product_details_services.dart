import 'dart:convert';

import 'package:amazon_app/constants/error%20handling.dart';
import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/constants/utils.dart';
import 'package:amazon_app/models/product.dart';
import 'package:amazon_app/models/user.dart';
import 'package:amazon_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {
  void rateproduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
          'rating': rating,
        }),
      );
      httperrorhandle(
        response: res,
        context: context,
        onsuccess: () {},
      );
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }

  void AddToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );
      httperrorhandle(
        response: res,
        context: context,
        onsuccess: () {
          User user = userprovider.user.copyWith(
            cart: jsonDecode(res.body)['cart'],
          );
          userprovider.setuserfrommodel(user);
        },
      );
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }
}
