import 'package:amazon_app/common/widgets/stars.dart';

import 'package:flutter/material.dart';

import 'package:amazon_app/models/product.dart';


class SearchProduct extends StatelessWidget {
  final Product product;
  const SearchProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalrating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalrating += product.rating![i].rating;
    }
    double avgrating = 0;

    if (totalrating != 0) {
      avgrating = totalrating / product.rating!.length;
    }
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Stars(
                      rating: avgrating,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\$${product.price}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Eligible for FREE Shipping',
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      'In Stock',
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
