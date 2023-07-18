import 'dart:io';

import 'package:amazon_app/common/widgets/custom%20button.dart';
import 'package:amazon_app/common/widgets/custom_textfield.dart';
import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/constants/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class addproducts extends StatefulWidget {
  static const String route = '/addproduct';
  const addproducts({super.key});

  @override
  State<addproducts> createState() => _addproductsState();
}

class _addproductsState extends State<addproducts> {
  final TextEditingController productname = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  String? Category = 'Mobiles';
  List<File> images = [];
  @override
  void dispose() {
    productname.dispose();
    description.dispose();
    price.dispose();
    quantity.dispose();
    super.dispose();
  }

  List<String> productcategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];

  void selectimages() async {
    var res = await pickimages();

    setState(() {
      
        images = res;
     
    });
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
            'Add Product',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? GestureDetector(
                        onTap: selectimages,
                        child: CarouselSlider(
                          items: images.map(
                            (i) {
                              return Builder(
                                builder: (BuildContext context) => Image.file(
                                  i,
                                  fit: BoxFit.cover,
                                  height: 200,
                                ),
                              );
                            },
                          ).toList(),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 200,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: selectimages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10),
                          dashPattern: [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 30,
                ),
                customtextfield(
                  textEditingController: productname,
                  hinttext: 'Product Name',
                ),
                SizedBox(
                  height: 10,
                ),
                customtextfield(
                  textEditingController: description,
                  hinttext: 'Description',
                  maxlines: 7,
                ),
                SizedBox(
                  height: 10,
                ),
                customtextfield(
                  textEditingController: price,
                  hinttext: 'Price',
                ),
                SizedBox(
                  height: 10,
                ),
                customtextfield(
                  textEditingController: quantity,
                  hinttext: 'Quantity',
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: Category,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: productcategories.map((String item) {
                      return DropdownMenuItem(
                        child: Text(item),
                        value: item,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        Category = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                custombutton(
                  text: 'Sell',
                  ontap: () {},
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
