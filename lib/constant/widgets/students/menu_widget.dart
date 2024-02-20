import 'package:erp_app/constant/colors.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget FullMenuWidget(
  double deviceHeight,
  double deviceWidth,
  bool newIndicator,
  String featureImagePath,
  String featureName,
) {
  return Container(
    width: deviceWidth * 0.2,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Stack(
          children: [
            _buildFeatureImageContainer(deviceHeight, featureImagePath),
            Visibility(
              visible: newIndicator,
              child: _buildNewIndicator(),
            ),
          ],
        ),
        _buildFeatureName(featureName),
      ],
    ),
  );
}

Widget _buildFeatureImageContainer(
    double deviceHeight, String featureImagePath) {
  return Stack(
    children: [
      Container(
        height: deviceHeight * 0.08,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 0.5,
              blurRadius: 0.5,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Image.asset(
            featureImagePath,
            height: deviceHeight * 0.02,
          ),
        ),
      ),
    ],
  );
}

Widget _buildNewIndicator() {
  return Padding(
    padding: const EdgeInsets.all(1.0),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/new.png'),
        Text(
          'new',
          style: AppTextStyles.sliderText.copyWith(fontSize: 7),
        ),
      ],
    ),
  );
}

Widget _buildFeatureName(String featureName) {
  return Text(
    featureName,
    style: AppTextStyles.sliderText.copyWith(
      color: TextColorScheme.secondaryTextColor,
    ),
    textAlign: TextAlign.center,
  );
}
