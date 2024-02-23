import 'package:erp_app/features/common/widgets/attendance_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ReusableCalendar extends StatefulWidget {
  const ReusableCalendar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReusableCalendarState createState() => _ReusableCalendarState();
}

class _ReusableCalendarState extends State<ReusableCalendar> {
  late DateTime focusedDay;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    focusedDay = DateTime.now();
    currentIndex = DateTime.now().month - 1; // Adjust to zero-based index
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 1.0,
              spreadRadius: 1.0,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Column(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (currentIndex > 0) {
                          currentIndex--;
                          focusedDay =
                              DateTime(focusedDay.year, currentIndex + 1, 1);
                        }
                      });
                    },
                    icon: const Icon(Icons.navigate_before),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Center(
                      child: Text(
                        DateFormat('MMMM').format(focusedDay),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (currentIndex < 11) {
                          currentIndex++;
                          focusedDay =
                              DateTime(focusedDay.year, currentIndex + 1, 1);
                        }
                      });
                    },
                    icon: const Icon(Icons.navigate_next),
                  ),
                ],
              ),
            ),
            TableCalendar(
              headerVisible: false,
              calendarFormat: CalendarFormat.month,
              onPageChanged: (DateTime focusedDay) {},
              calendarStyle: const CalendarStyle(
                defaultTextStyle: TextStyle(fontSize: 10.5),
                holidayTextStyle: TextStyle(fontSize: 10.5),
                weekendTextStyle: TextStyle(fontSize: 10.5),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontSize: 12),
                weekendStyle: TextStyle(fontSize: 12),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle:
                    TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              focusedDay: focusedDay,
              firstDay: DateTime(2023, 1, 1),
              lastDay: DateTime(2025, 12, 31),
              selectedDayPredicate: (day) {
                // Update this logic based on your markedDates or selected dates
                return isSameDay(day, focusedDay);
              },
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, date, events) {
                  Color cellColor = Colors.transparent;

                  // Check if the date is the focused day
                  if (isSameDay(date, focusedDay)) {
                    cellColor = Colors.green;
                  }

                  return Container(
                    margin: const EdgeInsets.all(11.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cellColor,
                    ),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            AttendaceStatusBar(),
          ],
        ),
      ),
    );
  }
}
