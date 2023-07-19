import 'dart:io';

import 'package:amazon_app/constants/error%20handling.dart';
import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/constants/utils.dart';
import 'package:amazon_app/models/product.dart';
import 'package:amazon_app/provider/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class adminservices {
  void sellproduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dasexcwzj', 'uocfcbal');
      List<String> imageurls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            images[i].path,
            folder: name,
          ),
        );

        imageurls.add(res.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageurls,
        category: category,
        price: price,
      );
      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
        },
        body: product.toJson(),
      );
      httperrorhandle(
          response: res,
          context: context,
          onsuccess: () {
            showsnackbar(context, 'Product Added Successfully!');
            Navigator.pop(context);
          });
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }
}
