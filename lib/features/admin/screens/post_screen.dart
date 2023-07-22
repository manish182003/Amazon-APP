import 'package:amazon_app/common/widgets/loader.dart';
import 'package:amazon_app/features/account/widgets/single_product.dart';
import 'package:amazon_app/features/admin/screens/add_product_screen.dart';
import 'package:amazon_app/features/admin/services/admin_services.dart';
import 'package:amazon_app/models/product.dart';
import 'package:flutter/material.dart';

class postscreen extends StatefulWidget {
  const postscreen({super.key});

  @override
  State<postscreen> createState() => _postscreenState();
}

class _postscreenState extends State<postscreen> {
  List<Product>? products;
  final adminservices admin = adminservices();
  @override
  void initState() {
    super.initState();
    fetchallproduts();
    setState(() {});
  }

  fetchallproduts() async {
    products = await admin.fetchAllProducts(context);

    setState(() {});
  }

  void deleteproduct(Product product, int index) async {
    admin.deleteproduct(
        context: context,
        product: product,
        onsuccess: () {
          products!.removeAt(index);
          setState(() {});
        });
  }

  void navigatetoaddproduct() {
    Navigator.pushNamed(context, addproducts.route);
  }

  @override
  Widget build(BuildContext context) {

    return products == null
        ? loader()
        : Scaffold(
            body: GridView.builder(
              itemCount: products!.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productdata = products![index];
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                    ),
                    SizedBox(
                      height: 140,
                      child: singleproduct(
                        image: productdata.images[0],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            productdata.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteproduct(productdata, index);
                          },
                          icon: Icon(Icons.delete_outline),
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                navigatetoaddproduct();
              },
              tooltip: 'Add a Product',
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
