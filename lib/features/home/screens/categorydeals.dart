import 'package:amazon_app/common/widgets/loader.dart';
import 'package:amazon_app/features/home/services/home_services.dart';
import 'package:amazon_app/features/product_details/screens/product_detail.dart';
import 'package:amazon_app/models/product.dart';
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
  List<Product>? productList;
  final homeservices home = homeservices();
  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await home.fetchcategoryproducts(
      context: context,
      Category: widget.category,
    );
    setState(() {});
  }

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
      body: productList == null
          ? const loader()
          : Column(
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
                    itemCount: productList!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.4,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final Product = productList![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ProductDetailsScreen.route,
                              arguments: Product);
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 130,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Image.network(
                                    Product.images[0],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(
                                left: 0,
                                top: 5,
                                right: 15,
                              ),
                              child: Text(
                                Product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
