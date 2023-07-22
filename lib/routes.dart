import 'package:amazon_app/common/widgets/bottom_bar.dart';
import 'package:amazon_app/features/admin/screens/add_product_screen.dart';
import 'package:amazon_app/features/auth/screens/auth_screen.dart';
import 'package:amazon_app/features/home/screens/categorydeals.dart';
import 'package:amazon_app/features/home/screens/homescreen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateroute(RouteSettings routeName) {
  final String? routeSettings = routeName.name;
  switch (routeSettings) {
    case authscreen.route:
      return MaterialPageRoute(
        settings: routeName,
        builder: (context) => const authscreen(),
      );
    case homescreen.route:
      return MaterialPageRoute(
        settings: routeName,
        builder: (context) => const homescreen(),
      );
    case Bottombar.route:
      return MaterialPageRoute(
        settings: routeName,
        builder: (context) => const Bottombar(),
      );
      case addproducts.route:
      return MaterialPageRoute(
        settings: routeName,
        builder: (context) => const addproducts(),
      );
        case CategoryDealScreens.route:
        var category=routeName.arguments as String ;
      return MaterialPageRoute(
       
        settings: routeName,
        builder: (context) =>  CategoryDealScreens(
          category: category,
        ),
      );
    default:
      return MaterialPageRoute(
        settings: routeName,
        builder: (context) => const Scaffold(
          body: Center(
            child: Text("Screen Does Not Exists"),
          ),
        ),
      );
  }
}
