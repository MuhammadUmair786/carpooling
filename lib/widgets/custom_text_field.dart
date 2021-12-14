import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final previousValue;
  final label;
  final placeholder;

  const CustomTextField({
    @required this.previousValue,
    @required this.label,
    @required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: TextEditingController(text: previousValue),
      // obscureText: isPasswordTextField ? showPassword : false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: BorderSide(
            width: 0.5,
            style: BorderStyle.none,
          ),
        ),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
      ),
    );
  }
}
