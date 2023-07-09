import 'package:flutter/material.dart';

class customtextfield extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hinttext;
  bool ispassword;

  customtextfield({
    Key? key,
    required this.textEditingController,
    required this.hinttext,
    this.ispassword = false,
  }) : assert(textEditingController != null);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textEditingController,
        obscureText: ispassword,
        decoration: InputDecoration(
          hintText: hinttext,
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          )),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter Your $hinttext';
          } else if (ispassword) {
            if (value.length < 8) {
              return '$hinttext length is less then 8';
            } else if (!value.contains(RegExp(r'[A-Z]'))) {
              return 'Password must contain at least one Uppercase character';
            } else if (!value.contains(RegExp(r'[0-9]'))) {
              return 'Password must contain at least one numeric character';
            } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
              return 'Password must contain at least one special character';
            } else if (!value.contains(RegExp(r'[a-z]'))) {
              return 'Password should contain at least one lowercase character';
            }
          } else
            return null;
        });
  }
}
