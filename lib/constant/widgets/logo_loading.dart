import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

// ignore: non_constant_identifier_names
Widget LogoLoading(double deviceHeight) {
  return SizedBox(
    height: deviceHeight * 0.05,
    child: Image.asset(
      'assets/acadSynk.png',
      fit: BoxFit.fitHeight,
    ).animate(delay: 100.ms).rotate(duration: 600.ms),
  );
}
