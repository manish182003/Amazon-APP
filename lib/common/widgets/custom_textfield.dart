import 'package:flutter/material.dart';

class customtextfield extends StatelessWidget {
 final  TextEditingController textEditingController;
 final String hinttext;

  const customtextfield({
    Key? key,
    required this.textEditingController,
    required this.hinttext,
  })
  :assert(textEditingController!=null);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hinttext,
          border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          )
          ),
          enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          )
          ),
        ), 
        validator: (value) {
          
        }, 


    );
  }
}
