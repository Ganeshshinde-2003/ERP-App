import 'package:flutter/material.dart';

class OnboardingItem extends StatelessWidget {
  final String imagePath;

  const OnboardingItem({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Image.asset(
            imagePath,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
        ],
      ),
    );
  }
}
