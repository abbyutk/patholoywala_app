import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final TextAlign? textAlign;
  final double textScaleFactor;
  const CustomText({
    Key? key,
    required this.text,
    required this.textStyle,
    this.textScaleFactor = 1,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      textAlign: textAlign,
      textScaleFactor: textScaleFactor,
    );
  }
}
