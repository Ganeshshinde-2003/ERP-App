import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeekdayNavigator extends StatelessWidget {
  final int currentIndex;
  final List<String> weekdays;
  final Function(int) onIndexChanged;

  const WeekdayNavigator({
    super.key,
    required this.currentIndex,
    required this.weekdays,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            if (currentIndex > 0) {
              onIndexChanged(currentIndex - 1);
            }
          },
          icon: const Icon(Icons.navigate_before),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Center(
            child: Text(
              weekdays[currentIndex],
              style: GoogleFonts.poppins(fontSize: 15),
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () {
            if (currentIndex < weekdays.length - 1) {
              onIndexChanged(currentIndex + 1);
            }
          },
          icon: const Icon(Icons.navigate_next),
        ),
      ],
    );
  }
}
