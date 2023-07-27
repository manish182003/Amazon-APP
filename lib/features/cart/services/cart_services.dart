import 'dart:convert';

import 'package:amazon_app/constants/error%20handling.dart';
import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/constants/utils.dart';
import 'package:amazon_app/models/product.dart';
import 'package:amazon_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';

class cartservices{




   void removefromcart({
    required BuildContext context,
    required Product product,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
        },
       
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