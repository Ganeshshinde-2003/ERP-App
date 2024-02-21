import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Divider(
        thickness: 1,
        indent: 2,
        endIndent: 4,
      ),
    );
  }
}
