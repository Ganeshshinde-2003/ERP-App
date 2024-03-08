import 'package:erp_app/constant/models/attendance_indi_model.dart';
import 'package:erp_app/features/common/widgets/attendance_status.dart';
import 'package:erp_app/features/student/controller/get_attedance_indi_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ReusableCalendar extends ConsumerStatefulWidget {
  const ReusableCalendar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ReusableCalendarState createState() => _ReusableCalendarState();
}

class _ReusableCalendarState extends ConsumerState<ReusableCalendar> {
  late DateTime focusedDay;
  late int currentIndex;
  AttendanceIndiModel? attendanceIndiModel;
  List<DateTime> absentDates = [];
  List<DateTime> presentDates = [];

  Future<void> getAttendanceData(dynamic month, dynamic year) async {
    attendanceIndiModel = await ref
        .read(getAttedanceIndiControllerProvider)
        .getIndiAttendance(month, year, "S", context);

    if (attendanceIndiModel != null) {
      final dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
      absentDates = attendanceIndiModel!.data.absentDates
          .map((dateString) => dateFormat.parse(dateString))
          .toList();

      presentDates = attendanceIndiModel!.data.presentDates
          .map((dateString) => dateFormat.parse(dateString))
          .toList();
    }
  }

  @override
  void initState() {
    super.initState();
    focusedDay = DateTime.now();
    currentIndex = DateTime.now().month - 1;
    Future.delayed(Duration.zero, () {
      _initializeData();
    });
  }

  Future<void> _initializeData() async {
    await getAttendanceData(focusedDay.month, focusedDay.year);
    setState(() {});
  }

  bool isSameDayList(DateTime date, List<DateTime> dateList) {
    return dateList.any((d) => isSameDay(date, d));
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<void> _onMonthChange(DateTime focusedDay) async {
    currentIndex = focusedDay.month - 1;
    await getAttendanceData(focusedDay.month, focusedDay.year);
    setState(() {});
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
                          _onMonthChange(focusedDay);
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
                          _onMonthChange(focusedDay);
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
              onPageChanged: _onMonthChange,
              calendarStyle: const CalendarStyle(
                defaultTextStyle: TextStyle(fontSize: 12),
                holidayTextStyle: TextStyle(fontSize: 12),
                weekendTextStyle: TextStyle(fontSize: 12),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontSize: 12),
                weekendStyle: TextStyle(fontSize: 12),
              ),
              focusedDay: focusedDay,
              firstDay: DateTime(2023, 1, 1),
              lastDay: DateTime(2025, 12, 31),
              selectedDayPredicate: (day) {
                return isSameDayList(day, [...absentDates, ...presentDates]);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  focusedDay = selectedDay;
                });
              },
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, date, events) {
                  Color cellColor = Colors.transparent;

                  if (isSameDayList(date, absentDates)) {
                    cellColor = Colors.red;
                  }

                  if (isSameDayList(date, presentDates)) {
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            AttendanceStatusBar(),
          ],
        ),
      ),
    );
  }
}
