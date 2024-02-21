import 'package:flutter/material.dart';

class BottomImageBar extends StatelessWidget {
  final double deviceWidth;

  const BottomImageBar({
    super.key,
    required this.deviceWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Image.asset(
        'assets/subpage-abstract-blue.png',
        width: deviceWidth,
      ),
    );
  }
}
