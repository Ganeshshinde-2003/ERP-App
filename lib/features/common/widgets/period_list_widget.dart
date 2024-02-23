// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PeriodsListWidget extends StatelessWidget {
  const PeriodsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Period> periods = [
      Period(
        subject: 'Math',
        start_time: '09:00 AM',
        end_time: '10:00 AM',
        teacher: 'Mr. Smith',
      ),
      Period(
        subject: 'Science',
        start_time: '10:15 AM',
        end_time: '11:15 AM',
        teacher: 'Ms. Johnson',
      ),
    ];
    return ListView.builder(
      itemCount: periods.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 1.0,
                    spreadRadius: 1.0)
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 15, left: 15, top: 4, bottom: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        periods[index].subject,
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${periods[index].start_time}-${periods[index].end_time}',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            letterSpacing: 1.1,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Text(
                    'Teacher : ${periods[index].teacher}',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Period {
  final String subject;
  final String start_time;
  final String end_time;
  final String teacher;

  Period({
    required this.subject,
    required this.start_time,
    required this.end_time,
    required this.teacher,
  });
}
