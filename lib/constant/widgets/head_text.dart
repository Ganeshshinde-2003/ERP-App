import 'package:erp_app/constant/text_style.dart';
import 'package:flutter/material.dart';

class Headingtext extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;

  const Headingtext({Key? key, required this.text, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textStyle ?? AppTextStyles.heading1);
  }
}
