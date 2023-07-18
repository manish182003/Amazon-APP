import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/features/admin/screens/post_screen.dart';
import 'package:flutter/material.dart';

class adminscreen extends StatefulWidget {
  const adminscreen({super.key});

  @override
  State<adminscreen> createState() => _adminscreenState();
}

class _adminscreenState extends State<adminscreen> {
  int page = 0;
  double bottombarwidth = 42;
  double borderwidth = 5;
  List<Widget> pages = [
    const postscreen(),
    const Center(
      child: Text('Analytics Page'),
    ),
    Center(
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
              Text(
                'Admin',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
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
                child: Icon(Icons.analytics_outlined),
              ),
            ),
            label: '',
          ),
          //orders
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
                child: Icon(Icons.all_inbox_outlined),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
