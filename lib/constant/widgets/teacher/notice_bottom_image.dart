import 'package:flutter/material.dart';

class BottomImageBar extends StatelessWidget {
  final double deviceWidth;
  final String color;

  const BottomImageBar({
    super.key,
    required this.deviceWidth,
    this.color = "blue",
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Image.asset(
        color == 'blue'
            ? 'assets/subpage-abstract-blue.png'
            : 'assets/subpage-abstract.png',
        width: deviceWidth,
      ),
    );
  }
}
