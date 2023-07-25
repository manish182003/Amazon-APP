import 'package:amazon_app/common/widgets/custom%20button.dart';
import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/features/cart/widgets/cart_product.dart';
import 'package:amazon_app/features/cart/widgets/cart_subtotal.dart';
import 'package:amazon_app/features/home/widgets/addressbox.dart';
import 'package:amazon_app/features/search/screens/searchscreen.dart';
import 'package:amazon_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigatetosearchscreen(String query) {
    Navigator.pushNamed(context, SearchScreen.route, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: globalvariable.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 8),
                  height: 42,
                  margin: EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigatetosearchscreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(top: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                padding: EdgeInsets.only(top: 8),
                child: Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const addressbox(),
            const cartsubtotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: custombutton(
                text: 'Proceed to Buy (${user.cart.length} items)',
                ontap: () {},
                color: Colors.yellow[600],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.black12.withOpacity(.08),
              height: 1,
            ),
            SizedBox(
              height: 5,
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return cartproduct(Index: index);
              },
              itemCount: user.cart.length,
              shrinkWrap: true,
            ),
            
          ],
        ),
      ),
    );
  }
}