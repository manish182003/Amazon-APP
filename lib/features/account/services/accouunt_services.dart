import 'dart:convert';

import 'package:amazon_app/constants/error%20handling.dart';
import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/constants/utils.dart';
import 'package:amazon_app/features/auth/screens/auth_screen.dart';

import 'package:amazon_app/models/order.dart';
import 'package:amazon_app/provider/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class accountservices {
  Future<List<order>> fetchmyorders({
    required BuildContext context,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;
    List<order> orderlist = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/order/me'),
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
              orderlist.add(
                order.fromJson(
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
    return orderlist;
  }

  void logout(BuildContext context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
          context, authscreen.route, (route) => false);
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }
}
