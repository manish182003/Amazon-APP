import 'package:flutter/material.dart';

import 'package:amazon_app/constants/global%20variable.dart';

class CategoryDealScreens extends StatefulWidget {
  static const String route = '/category-deals';
  final String category;
  const CategoryDealScreens({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryDealScreens> createState() => _CategoryDealScreensState();
}

class _CategoryDealScreensState extends State<CategoryDealScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: globalvariable.appBarGradient,
            ),
          ),
          title: Text(
            widget.category,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(
              'keep Shopping for ${widget.category}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 170,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(
                left: 15,
              ),
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.4,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Text('hello');
              },
            ),
          ),
        ],
      ),
    );
  }
}
