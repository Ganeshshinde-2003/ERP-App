import 'package:flutter/material.dart';

class PositionedImageWidget extends StatelessWidget {
  final double top;
  final double left;
  final String imagePath;

  const PositionedImageWidget({
    super.key,
    required this.top,
    required this.left,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.17,
        child: Image.asset(
          imagePath,
        ),
      ),
    );
  }
}
