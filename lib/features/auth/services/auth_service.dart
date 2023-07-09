import 'dart:convert';

import 'package:amazon_app/constants/error%20handling.dart';
import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/constants/utils.dart';
import 'package:amazon_app/features/home/screens/homescreen.dart';
import 'package:amazon_app/models/user.dart';
import 'package:amazon_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class authservice {
  //sign up user

  void signupuser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: "",
          name: name,
          password: password,
          email: email,
          address: "",
          type: "",
          token: "");

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httperrorhandle(
        response: res,
        context: context,
        onsuccess: () {
          showsnackbar(
            context,
            'Account Created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }

  //signin user

  void signinuser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      httperrorhandle(
        response: res,
        context: context,
        onsuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setuser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            homescreen.route,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }
}
