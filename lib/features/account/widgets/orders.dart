import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
//temporary list

  List list = [
    'https://www.pngmart.com/files/15/Apple-iPhone-11-PNG-HD.png',
    'https://www.pngmart.com/files/15/Apple-iPhone-12-Transparent-PNG.png',
    'https://www.pngmart.com/files/22/iPhone-14-PNG-Transparent.png',
    'https://www.pngmart.com/files/22/iPhone-14-PNG-Transparent.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
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
              return singleproduct(image: list[index]);
            },
            itemCount: list.length,
          ),
        ),
      ],
    );
  }
}
