import 'package:flutter/material.dart';

class custombutton extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  final Color? color;
  const custombutton({
    Key? key,
    required this.text,
    required this.ontap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(
          color: color == null ? Colors.white : Colors.black,
        ),
      ),
      onPressed: () {
        ontap();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        primary: color,
      ),
    );
  }
}
