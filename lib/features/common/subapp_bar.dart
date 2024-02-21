import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/app_bar.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
PreferredSize SubPageAppBar(BuildContext context, String title) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: ClipPath(
      clipper: AppBarClipper(),
      child: Container(
        color: Colors.black,
        child: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/back.png',
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          title: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 5,
                bottom: 5,
              ),
              child: Text(
                title,
                style: AppTextStyles.sliderText.copyWith(fontSize: 15),
              ),
            ),
          ),
          centerTitle: true,
        ),
      ),
    ),
  );
}
