import 'package:erp_app/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadDiscWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const HeadDiscWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, bottom: 20),
          child: Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: TextColorScheme.secondaryTextColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
