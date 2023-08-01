import 'package:amazon_app/common/widgets/loader.dart';
import 'package:amazon_app/features/account/widgets/single_product.dart';
import 'package:amazon_app/features/admin/services/admin_services.dart';
import 'package:amazon_app/features/order_details/screens/order_detail.dart';
import 'package:amazon_app/models/order.dart';
import 'package:flutter/material.dart';

class orderscreens extends StatefulWidget {
  const orderscreens({super.key});

  @override
  State<orderscreens> createState() => _orderscreensState();
}

class _orderscreensState extends State<orderscreens> {
  List<order>? orders;
  adminservices admin = adminservices();
  @override
  void initState() {
    super.initState();
    fetchmyorders();
  }

  fetchmyorders() async {
    orders = await admin.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? loader()
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderdata = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, orderdetailscreen.route,
                      arguments: orderdata);
                },
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: 140,
                    child: singleproduct(
                      image: orderdata.products[0].images[0],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
