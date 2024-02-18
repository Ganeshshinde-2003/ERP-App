import 'package:erp_app/constant/text_style.dart';
import 'package:flutter/material.dart';

class QueryContactInfoWidget extends StatelessWidget {
  final VoidCallback? onTapContactAdmin;
  final String headText;
  final String discText;
  final double pad;

  const QueryContactInfoWidget({
    Key? key,
    this.onTapContactAdmin,
    required this.discText,
    required this.headText,
    this.pad = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapContactAdmin,
      child: Padding(
        padding: EdgeInsets.only(top: pad),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(headText, style: AppTextStyles.heading2),
            GestureDetector(
              onTap: onTapContactAdmin,
              child: Text(
                discText,
                style: AppTextStyles.highlightedText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
