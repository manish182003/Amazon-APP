import 'dart:convert';

import 'package:amazon_app/constants/error%20handling.dart';
import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/constants/utils.dart';
import 'package:amazon_app/models/product.dart';
import 'package:amazon_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SearchServices {
  Future<List<Product>> fetchsearchproducts({
    required BuildContext context,
    required String searchquery,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productlist = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products/search/$searchquery'),
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
}
