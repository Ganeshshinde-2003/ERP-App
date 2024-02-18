import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedLogoText extends StatelessWidget {
  final double deviceHeight;
  final double imageHeight;
  final double fontSize;

  const AnimatedLogoText({
    Key? key,
    required this.deviceHeight,
    this.imageHeight = 0.08,
    this.fontSize = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/acadSynk.png',
            height: deviceHeight * imageHeight,
          ),
          Text(
            'cadSynk',
            style: GoogleFonts.poppins(fontSize: fontSize),
          )
        ],
      ),
    );
  }
}

class AnimatedLogoAndContactWidget extends StatelessWidget {
  final double deviceHeight;
  final double imageHeight;
  final double fontSize;

  const AnimatedLogoAndContactWidget({
    Key? key,
    required this.deviceHeight,
    this.imageHeight = 0.08,
    this.fontSize = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedLogoText(
          deviceHeight: deviceHeight,
          imageHeight: imageHeight,
          fontSize: fontSize,
        )
            .animate()
            .moveX(duration: const Duration(seconds: 1))
            .fadeIn(duration: const Duration(seconds: 1)),
      ],
    );
  }
}
