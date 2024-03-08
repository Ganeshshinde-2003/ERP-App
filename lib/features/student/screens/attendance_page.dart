import 'package:flutter/material.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/common/widgets/calender_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentAttendancePageScreen extends ConsumerStatefulWidget {
  const StudentAttendancePageScreen({super.key});

  @override
  ConsumerState<StudentAttendancePageScreen> createState() =>
      _StudentAttendancePageScreenState();
}

class _StudentAttendancePageScreenState
    extends ConsumerState<StudentAttendancePageScreen> {
  final DateTime focusedDay = DateTime.now();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(context, 'Attendance'),
      body: Stack(
        children: [
          BottomImageBar(
            deviceWidth: deviceWidth,
            color: "green",
          ),
          Column(
            children: [
              SizedBox(height: deviceHeight * 0.03),
              const ReusableCalendar(),
            ],
          )
        ],
      ),
    );
  }
}
