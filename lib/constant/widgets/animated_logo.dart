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

class AnimatedLogoAndContactWidget extends StatefulWidget {
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
  _AnimatedLogoAndContactWidgetState createState() =>
      _AnimatedLogoAndContactWidgetState();
}

class _AnimatedLogoAndContactWidgetState
    extends State<AnimatedLogoAndContactWidget> {
  @override
  void initState() {
    super.initState();
    // Start animation when the widget is first initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startAnimation();
    });
  }

  void startAnimation() {
    // Use setState to trigger the animation
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedLogoText(
          deviceHeight: widget.deviceHeight,
          imageHeight: widget.imageHeight,
          fontSize: widget.fontSize,
        )
            .animate()
            .moveX(duration: const Duration(seconds: 1))
            .fadeIn(duration: const Duration(seconds: 1)),
      ],
    );
  }
}
