import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final TextStyle? textStyle;

  const CustomText(
      {required this.text, this.size, this.color, this.weight, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: textStyle ??
          TextStyle(
              fontSize: size ?? 16,
              color: color ?? Colors.black,
              fontWeight: weight ?? FontWeight.normal,
              decoration: TextDecoration.none),
    );
  }
}
