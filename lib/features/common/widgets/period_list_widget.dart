import 'package:erp_app/constant/models/student_time_table_model.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/features/student/controller/section_time_table_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PeriodsListWidget extends ConsumerStatefulWidget {
  final String day;

  const PeriodsListWidget({Key? key, required this.day}) : super(key: key);

  @override
  ConsumerState<PeriodsListWidget> createState() => _PeriodsListWidgetState();
}

class _PeriodsListWidgetState extends ConsumerState<PeriodsListWidget> {
  StudentSectionTimeTable? sectionTimeTable;

  void getTimeTable() async {
    StudentSectionTimeTable? localTimeTable = await ref
        .read(studentSectionTimeTableControllerProvider)
        .getTimeTableBySection(context);
    setState(() {
      sectionTimeTable = localTimeTable;
    });
  }

  @override
  void initState() {
    getTimeTable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;

    if (sectionTimeTable != null &&
        sectionTimeTable!.data.containsKey(widget.day)) {
      List<Period> periods = sectionTimeTable!.data[widget.day]!
          .map((session) => Period(
                subject: session.sessionID.subjectId.subjectName,
                starttime: session.startTime,
                endtime: session.endTime,
                teacher: session.teacherID.employeeName,
              ))
          .toList();

      DateTime parseTime(String time) {
        final timeFormat = DateFormat.jm();
        final parsedDate = DateTime(2022, 1, 1);
        try {
          return DateTime(
            parsedDate.year,
            parsedDate.month,
            parsedDate.day,
            timeFormat.parse(time).hour,
            timeFormat.parse(time).minute,
          );
        } catch (e) {
          return DateTime.now();
        }
      }

      periods.sort((a, b) {
        final aTime = parseTime(a.starttime);
        final bTime = parseTime(b.starttime);

        return aTime.isBefore(bTime) ? -1 : 1;
      });

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
                      spreadRadius: 1.0),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 15, left: 15, top: 4, bottom: 4),
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
                          '${periods[index].starttime}-${periods[index].endtime}',
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
    } else {
      return Center(child: NoDataFound(deviceHeight, "assets/no_data.json"));
    }
  }
}

class Period {
  final String subject;
  final String starttime;
  final String endtime;
  final String teacher;

  Period({
    required this.subject,
    required this.starttime,
    required this.endtime,
    required this.teacher,
  });
}
