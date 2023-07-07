import 'package:flutter/material.dart';

class custombutton extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  const custombutton({
    Key? key,
    required this.text,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
      ),
      onPressed: () {},
      style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
    );
  }
}
