import 'package:erp_app/constant/text_style.dart';
import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content, style: AppTextStyles.heading2),
      backgroundColor: Colors.black,
      duration: const Duration(milliseconds: 500),
    ),
  );
}
