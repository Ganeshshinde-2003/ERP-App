import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomUserInfoWidget extends StatelessWidget {
  final String name;
  final String role;
  final String rollNo;
  final String classNo;
  final String teacher;
  const CustomUserInfoWidget({
    super.key,
    required this.name,
    required this.role,
    this.teacher = "Staff",
    this.rollNo = '0135',
    this.classNo = "XI",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi $name',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Text(
                role == "teacher"
                    ? '$teacher | Teacher '
                    : "Class $classNo | Roll no: $rollNo",
                style: GoogleFonts.poppins(
                    fontSize: 11, color: Colors.grey.shade600),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 1),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Image.asset(
              'assets/avatar.png',
              height: 50,
              width: 45,
            ),
          ),
        ),
      ],
    );
  }
}
