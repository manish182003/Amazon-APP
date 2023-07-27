import 'dart:io';

import 'package:amazon_app/constants/utils.dart';
import 'package:amazon_app/features/address/services/address_services.dart';
import 'package:amazon_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay/pay.dart';

import 'package:amazon_app/common/widgets/custom_textfield.dart';
import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/constants/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String route = '/address';
  final String totalamount;
  const AddressScreen({
    Key? key,
    required this.totalamount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatcontroller = TextEditingController();
  final TextEditingController areacontroller = TextEditingController();
  final TextEditingController pincodecontroller = TextEditingController();
  final TextEditingController citycontroller = TextEditingController();
  final addressformkey = GlobalKey<FormState>();
  List<PaymentItem> paymentitems = [];
  final addressservices ADDRESSSERVICE = addressservices();
  String addresstobeused = '';

  @override
  void initState() {
    super.initState();
    paymentitems.add(PaymentItem(
      amount: widget.totalamount,
      label: 'Total Amount',
      status: PaymentItemStatus.final_price,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    flatcontroller.dispose();
    areacontroller.dispose();
    pincodecontroller.dispose();
    citycontroller.dispose();
  }

  void onpayresult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      ADDRESSSERVICE.saveuseraddress(
          context: context, useraddress: addresstobeused);
    }
    ADDRESSSERVICE.placeorder(
        context: context,
        address: addresstobeused,
        totalsum: double.parse(widget.totalamount));
  }

  void paypressed(String addressfromprovider) {
    addresstobeused = '';

    bool isform = flatcontroller.text.isNotEmpty ||
        pincodecontroller.text.isNotEmpty ||
        areacontroller.text.isNotEmpty ||
        citycontroller.text.isNotEmpty;

    if (isform) {
      if (addressformkey.currentState!.validate()) {
        addresstobeused =
            '${flatcontroller.text},${areacontroller.text},${citycontroller.text}-${pincodecontroller.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressfromprovider.isNotEmpty) {
      addresstobeused = addressfromprovider;
    } else {
      showsnackbar(context, 'ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: globalvariable.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.black12,
                      )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: addressformkey,
                child: Column(
                  children: [
                    customtextfield(
                      textEditingController: flatcontroller,
                      hinttext: "Flat, House no, Building",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    customtextfield(
                      textEditingController: areacontroller,
                      hinttext: "Area, Street",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    customtextfield(
                      textEditingController: pincodecontroller,
                      hinttext: "Pincode",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    customtextfield(
                      textEditingController: citycontroller,
                      hinttext: "Town/City",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (!Platform.isIOS)
                GooglePayButton(
                  onPressed: () {
                    paypressed(address);
                    setState(() {});
                  },
                  onPaymentResult: onpayresult,
                  paymentItems: paymentitems,
                  type: GooglePayButtonType.buy,
                  paymentConfiguration:
                      PaymentConfiguration.fromJsonString(defaultGooglePay),
                  width: double.infinity,
                  height: 50,
                  loadingIndicator: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
