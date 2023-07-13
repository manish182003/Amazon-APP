import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class belowappbar extends StatelessWidget {
  const belowappbar({super.key});

  @override
  Widget build(BuildContext context) {
    final User = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: BoxDecoration(
        gradient: globalvariable.appBarGradient,
      ),
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: 'Hello, ',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: User.name,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
