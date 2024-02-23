import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendaceStatusBar extends StatelessWidget {
  final Color presentColor;
  final Color absentColor;
  final Color naColor;

  AttendaceStatusBar({
    super.key,
    Color? presentColor,
    Color? absentColor,
    Color? naColor,
  })  : presentColor = presentColor ?? Colors.green,
        absentColor = absentColor ?? Colors.red,
        naColor = naColor ?? Colors.blueGrey[300]!;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LegendItem(color: presentColor, label: 'Present'),
          const SizedBox(width: 12),
          LegendItem(color: absentColor, label: 'Absent'),
          const SizedBox(width: 12),
          LegendItem(color: naColor, label: 'N/A'),
        ],
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 5,
          backgroundColor: color,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12),
        ),
      ],
    );
  }
}
