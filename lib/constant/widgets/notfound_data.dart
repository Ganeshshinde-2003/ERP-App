import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

// ignore: non_constant_identifier_names
Widget NoDataFound(double deviceHeight, String json) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(json, height: deviceHeight * 0.25),
        SizedBox(
          height: deviceHeight * 0.02,
        ),
        Image.asset(
          'assets/acadSynk.png',
          height: deviceHeight * 0.05,
        ),
        Text(
          'No Data Found',
          style: GoogleFonts.poppins(),
        ),
      ],
    ),
  );
}
