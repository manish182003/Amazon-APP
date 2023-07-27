import 'dart:convert';

import 'package:amazon_app/constants/error%20handling.dart';
import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/constants/utils.dart';
import 'package:amazon_app/models/user.dart';
import 'package:amazon_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class addressservices {
  void saveuseraddress({
    required BuildContext context,
    required String useraddress,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
        },
        body: jsonEncode({
          'address': useraddress,
        }),
      );
      httperrorhandle(
        response: res,
        context: context,
        onsuccess: () {
          User user = userprovider.user.copyWith(
            address: jsonDecode(res.body)['address'],
          );
          userprovider.setuserfrommodel(user);
        },
      );
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }

  void placeorder({
    required BuildContext context,
    required String address,
    required double totalsum,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/order'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
        },
        body: jsonEncode({
          'cart': userprovider.user.cart,
          'address': address,
          'totalPrice': totalsum,
        }),
      );
      httperrorhandle(
        response: res,
        context: context,
        onsuccess: () {
          showsnackbar(context, 'Your Order has been placed');
          User user = userprovider.user.copyWith(
            cart: [],
          );
          userprovider.setuserfrommodel(user);
        },
      );
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }
}
