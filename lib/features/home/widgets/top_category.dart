import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/features/home/screens/categorydeals.dart';
import 'package:flutter/material.dart';

class topcategory extends StatelessWidget {
  const topcategory({super.key});

  void navigatetocategorypage(BuildContext context, String Category) {
    Navigator.pushNamed(context, CategoryDealScreens.route,
        arguments: Category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 80,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              navigatetocategorypage(
                context,
                globalvariable.categoryImages[index]['title']!,
              );
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      globalvariable.categoryImages[index]['image']!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Text(
                  globalvariable.categoryImages[index]['title']!,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
        },
        itemCount: globalvariable.categoryImages.length,
      ),
    );
  }
}