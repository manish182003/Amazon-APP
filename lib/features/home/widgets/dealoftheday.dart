import 'package:flutter/material.dart';

class dealoftheday extends StatefulWidget {
  const dealoftheday({super.key});

  @override
  State<dealoftheday> createState() => _dealofthedayState();
}

class _dealofthedayState extends State<dealoftheday> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 10, top: 15),
          child: Text(
            'Deal of the Day',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Image.network(
          'https://www.pngmart.com/files/7/Dell-Laptop-PNG-HD.png',
          height: 235,
          fit: BoxFit.fitHeight,
        ),
        Container(
          padding: EdgeInsets.only(left: 15),
          alignment: Alignment.topLeft,
          child: Text(
            '\$100',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(
            left: 15,
            top: 5,
            right: 40,
          ),
          child: Text(
            'DELL LAPTOP',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                'https://www.pngmart.com/files/16/Portable-Laptop-Top-View-Transparent-Background.png',
                fit: BoxFit.fitWidth,
                width: 405,
                height: 405,
              ),
              Image.network(
                'https://www.pngmart.com/files/1/Laptop-PNG-Free-Download.png',
                fit: BoxFit.fitWidth,
                width: 405,
                height: 405,
              ),
              Image.network(
                'https://www.pngmart.com/files/6/Dell-Laptop-PNG-Transparent.png',
                fit: BoxFit.fitWidth,
                width: 405,
                height: 405,
              ),
              Image.network(
                'https://www.pngmart.com/files/4/Toshiba-Laptop-PNG-Clipart.png',
                fit: BoxFit.fitWidth,
                width: 405,
                height: 405,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: 15,
            top: 15,
            bottom: 15,
          ),
          alignment: Alignment.topLeft,
          child: Text(
            'See all deals',
            style: TextStyle(
              color: Colors.cyan[800],
            ),
          ),
        ),
      ],
    );
  }
}
