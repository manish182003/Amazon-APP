import 'dart:convert';
import 'dart:io';

import 'package:amazon_app/constants/error%20handling.dart';
import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/constants/utils.dart';
import 'package:amazon_app/features/admin/sales.dart';
import 'package:amazon_app/models/order.dart';
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

  //get all the products
  Future<List<Product>> fetchAllProducts(
    BuildContext context,
  ) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productlist = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products'),
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

  //delete the product
  void deleteproduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onsuccess,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
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
            onsuccess();
          });
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }

  Future<List<order>> fetchAllOrders(
    BuildContext context,
  ) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;
    List<order> orderlist = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-orders'),
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

  void changeorderstatus({
    required BuildContext context,
    required int status,
    required order order,
    required VoidCallback onsuccess,
  }) async {
    try {
      final userprovider =
          Provider.of<UserProvider>(context, listen: false).user;

      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );
      httperrorhandle(response: res, context: context, onsuccess: onsuccess);
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getearnings(
    BuildContext context,
  ) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;
    List<Sales> sales = [];
    int totalearning = 0;
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/analytics'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.token,
        },
      );
      httperrorhandle(
          response: res,
          context: context,
          onsuccess: () {
            var response = jsonDecode(res.body);
            totalearning = response['totalearning'];
            sales = [
              Sales('Mobiles', response['mobileearning']),
               Sales('Essentials', response['essentialearning']),
                Sales('Books', response['booksearning']),
                 Sales('Appliances', response['applianceseearning']),
                  Sales('Fashion', response['fashionearning']),
            ];
          });
    } catch (e) {
      showsnackbar(context, e.toString());
    }
    return {
      'sales':sales,
      'totalearning':totalearning,
    };
  }
}
