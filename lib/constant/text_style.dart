import 'package:erp_app/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle get heading1 => GoogleFonts.nunito(
        color: TextColorScheme.primaryTextColor,
        fontSize: 19,
        fontWeight: FontWeight.w800,
      );

  static TextStyle get heading2 => GoogleFonts.nunito(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: TextColorScheme.secondaryTextColor,
      );

  static TextStyle get bodyText => GoogleFonts.nunito(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  static TextStyle get highlightedText => GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: TextColorScheme.buleTextColor,
      );
  static TextStyle get buttonText => GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get sliderText => GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 10,
        fontWeight: FontWeight.w500,
      );
}
