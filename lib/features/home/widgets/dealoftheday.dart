import 'package:amazon_app/common/widgets/loader.dart';
import 'package:amazon_app/features/home/services/home_services.dart';
import 'package:amazon_app/features/product_details/screens/product_detail.dart';
import 'package:amazon_app/models/product.dart';
import 'package:flutter/material.dart';

class dealoftheday extends StatefulWidget {
  const dealoftheday({super.key});

  @override
  State<dealoftheday> createState() => _dealofthedayState();
}

class _dealofthedayState extends State<dealoftheday> {
  Product? product;
  final homeservices home = homeservices();
  @override
  void initState() {
    super.initState();
    fetchdealofday();
  }

  void navigatotodetailscreen() {
    Navigator.pushNamed(context, ProductDetailsScreen.route,
        arguments: product);
  }

  fetchdealofday() async {
    product = await home.fetchDealOfTheDay(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? loader()
        : product!.name.isEmpty
            ? SizedBox()
            : GestureDetector(
                onTap: navigatotodetailscreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 10, top: 15),
                      child: Text(
                        'Deal of the Day',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      height: 300,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '\$100',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(
                        left: 15,
                        top: 5,
                        right: 40,
                      ),
                      child: Text(
                        'DELL LAPTOP',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: product!.images
                              .map(
                                (e) => Image.network(
                                  e,
                                  fit: BoxFit.fitWidth,
                                  width: 200,
                                  height: 200,
                                ),
                              )
                              .toList()),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 15,
                        top: 15,
                        bottom: 15,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See all deals',
                        style: TextStyle(
                          color: Colors.cyan[800],
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
