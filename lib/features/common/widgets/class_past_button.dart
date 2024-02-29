import 'package:erp_app/constant/text_style.dart';
import 'package:flutter/material.dart';

class ReusableClassButtonWidget extends StatelessWidget {
  final String title;
  final String buttonText;
  final Widget onPressed;

  const ReusableClassButtonWidget({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 15),
            child: Text(
              title,
              style: AppTextStyles.heading2,
            ),
          ),
          // TextButton(
          //   onPressed: () => {
          //     Navigator.push(
          //       context,
          //       PageTransition(
          //         type: PageTransitionType.fade,
          //         alignment: Alignment.lerp(
          //           Alignment.centerLeft,
          //           Alignment.centerLeft,
          //           0.5,
          //         ),
          //         child: onPressed,
          //       ),
          //     )
          //   },
          //   style: TextButton.styleFrom(
          //     backgroundColor: Colors.blue,
          //   ),
          //   child: Text(
          //     buttonText,
          //     style: AppTextStyles.sliderText.copyWith(
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
