import 'package:amazon_app/common/widgets/custom%20button.dart';
import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/features/admin/screens/admin_screen.dart';
import 'package:amazon_app/features/admin/services/admin_services.dart';
import 'package:amazon_app/features/search/screens/searchscreen.dart';
import 'package:amazon_app/models/user.dart';
import 'package:amazon_app/provider/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:amazon_app/models/order.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class orderdetailscreen extends StatefulWidget {
  static const String route = '/order-details';
  final order orders;

  const orderdetailscreen({
    Key? key,
    required this.orders,
  }) : super(key: key);

  @override
  State<orderdetailscreen> createState() => _orderdetailscreenState();
}

class _orderdetailscreenState extends State<orderdetailscreen> {
  int currentstep = 0;
  final adminservices admin = adminservices();

  @override
  void initState() {
    super.initState();
    currentstep = widget.orders.status;
  }

  void changeorderstatus(int status) {
    admin.changeorderstatus(
        context: context,
        status: status + 1,
        order: widget.orders,
        onsuccess: () {
          setState(() {
            currentstep += 1;
          });
        });
  }

  void navigatetosearchscreen(String query) {
    Navigator.pushNamed(context, SearchScreen.route, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'View Order Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Date :     ${DateFormat().format(
                      DateTime.fromMillisecondsSinceEpoch(
                          widget.orders.orderat),
                    )}'),
                    Text('Order ID :          ${widget.orders.id}'),
                    Text('Order Total :     \$${widget.orders.totalPrice}'),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Purchase Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.orders.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.orders.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.orders.products[i].name,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text('Qty: ${widget.orders.quantity[i]}'),
                              ],
                            ),
                          )
                        ],
                      )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Tracking',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Stepper(
                    currentStep: currentstep,
                    controlsBuilder: (context, details) {
                      if (user.type == 'admin') {
                        return custombutton(
                          text: 'Done',
                          ontap: () {
                            changeorderstatus(details.currentStep);
                          },
                        );
                      }

                      return SizedBox();
                    },
                    steps: [
                      Step(
                        title: Text('Pending'),
                        content: Text('Your Order is Yet o be Delivered'),
                        isActive: currentstep >= 0,
                        state: currentstep > 0
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: Text('Completed'),
                        content: Text(
                            'Your Order has been delivered, you are yet to sign'),
                        isActive: currentstep > 1,
                        state: currentstep > 1
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: Text('Received'),
                        content: Text(
                            'Your Order has been delivered and signed by you.'),
                        isActive: currentstep > 2,
                        state: currentstep > 2
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: Text('Delivered'),
                        content: Text(
                            'Your Order has been delivered and signed by you!'),
                        isActive: currentstep >= 3,
                        state: currentstep >= 3
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
