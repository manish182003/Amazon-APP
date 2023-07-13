import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/features/account/screens/accountscreen.dart';
import 'package:amazon_app/features/home/screens/homescreen.dart';
import 'package:flutter/material.dart';

class Bottombar extends StatefulWidget {
  static const String route = '/actualhome';
  const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int page = 0;
  double bottombarwidth = 42;
  double borderwidth = 5;
  List<Widget> pages = [
    const homescreen(),
    const accountscreen(),
    const Center(
      child: Text('Cart Page'),
    ),
  ];

  void updatepage(int page) {
    setState(() {
      this.page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        selectedItemColor: globalvariable.selectedNavBarColor,
        unselectedItemColor: globalvariable.unselectedNavBarColor,
        backgroundColor: globalvariable.backgroundColor,
        iconSize: 28,
        onTap: updatepage,
        items: [
          //homepage
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: bottombarwidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: page == 0
                          ? globalvariable.selectedNavBarColor
                          : globalvariable.backgroundColor,
                      width: borderwidth,
                    ),
                  ),
                ),
                child: Icon(Icons.home_outlined),
              ),
            ),
            label: '',
          ),
          //account
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: bottombarwidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: page == 1
                          ? globalvariable.selectedNavBarColor
                          : globalvariable.backgroundColor,
                      width: borderwidth,
                    ),
                  ),
                ),
                child: Icon(Icons.person_outline_outlined),
              ),
            ),
            label: '',
          ),
          //cart
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: bottombarwidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: page == 2
                          ? globalvariable.selectedNavBarColor
                          : globalvariable.backgroundColor,
                      width: borderwidth,
                    ),
                  ),
                ),
                child: Badge(
                  label: Text('2'),
                  textColor: Colors.black,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: Colors.white,
                  child: Icon(Icons.shopping_cart_outlined),
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
