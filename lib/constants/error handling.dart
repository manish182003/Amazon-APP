import 'dart:convert';

import 'package:amazon_app/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httperrorhandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onsuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onsuccess();
      break;

    case 402:
      showsnackbar(context, jsonDecode(response.body)['msg']);
      break;
    case 400:
      showsnackbar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showsnackbar(context, jsonDecode(response.body)['error']);
      break;

    default:
      showsnackbar(context, response.body);
  }
}
