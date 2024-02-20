import 'package:erp_app/constant/text_style.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget SmallDashboard(String backgroundImagePath, String featureImagePath,
    double deviceHeight, String featureName) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        height: deviceHeight * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Image.asset(
          backgroundImagePath,
          fit: BoxFit.fill,
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            featureImagePath,
            color: Colors.white,
            height: deviceHeight * 0.035,
          ),
          SizedBox(
            height: deviceHeight * 0.007,
          ),
          Text(
            featureName,
            style: AppTextStyles.sliderText.copyWith(
              fontSize: 12,
              color: Colors.white,
            ),
          )
        ],
      )
    ],
  );
}
