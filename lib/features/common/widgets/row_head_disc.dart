import 'package:erp_app/constant/text_style.dart';
import 'package:flutter/material.dart';

class RowHeadDiscWidget extends StatelessWidget {
  final String head;
  final String disc;
  const RowHeadDiscWidget({super.key, required this.head, required this.disc});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$head : ',
          style: AppTextStyles.heading2,
        ),
        Text(
          disc,
          style: AppTextStyles.heading2.copyWith(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
