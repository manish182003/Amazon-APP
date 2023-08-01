import 'package:amazon_app/common/widgets/loader.dart';
import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/features/account/services/accouunt_services.dart';
import 'package:amazon_app/features/account/widgets/single_product.dart';
import 'package:amazon_app/features/order_details/screens/order_detail.dart';
import 'package:amazon_app/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<order>? orders;
  accountservices account = accountservices();

  @override
  void initState() {
    super.initState();
    fetchorders();
  }

  void fetchorders() async {
    orders = await account.fetchmyorders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: globalvariable.selectedNavBarColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              //DISPLAY ORDERS
              Container(
                height: 170,
                padding: EdgeInsets.only(left: 10, top: 20, right: 0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          orderdetailscreen.route,
                          arguments: orders![index],
                        );
                      },
                      child: singleproduct(
                          image: orders![index].products[0].images[0]),
                    );
                  },
                  itemCount: orders!.length,
                ),
              ),
            ],
          );
  }
}
