import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/features/account/widgets/below_appbar.dart';
import 'package:amazon_app/features/account/widgets/top_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class accountscreen extends StatelessWidget {
  const accountscreen({super.key});

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 8),
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          belowappbar(),
          SizedBox(
            height: 10,
          ),
          topbuttons(),
        ],
      ),
    );
  }
}
