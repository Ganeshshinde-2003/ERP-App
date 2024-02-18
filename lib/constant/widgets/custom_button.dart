import 'package:erp_app/constant/text_style.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomButtonWidget({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.black),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white))
              : Center(
                  child: Text(buttonText, style: AppTextStyles.buttonText),
                ),
        ),
      ),
    );
  }
}
