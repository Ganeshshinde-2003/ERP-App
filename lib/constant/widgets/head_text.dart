import 'package:erp_app/constant/text_style.dart';
import 'package:flutter/material.dart';

class Headingtext extends StatelessWidget {
  final String text;

  const Headingtext({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyles.heading1);
  }
}
