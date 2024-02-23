import 'package:erp_app/constant/widgets/logo_loading.dart';
import 'package:erp_app/features/common/widgets/percent_total_widget.dart';
import 'package:flutter/material.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/common/widgets/calender_widget.dart';

class StudentAttendancePageScreen extends StatefulWidget {
  const StudentAttendancePageScreen({super.key});

  @override
  State<StudentAttendancePageScreen> createState() =>
      _StudentAttendancePageScreenState();
}

class _StudentAttendancePageScreenState
    extends State<StudentAttendancePageScreen> {
  final DateTime focusedDay = DateTime.now();
  bool isLoading = false;
  final List<DateTime> markedDates = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 2)),
    DateTime.now().add(const Duration(days: 5)),
    // Add more static dates as needed
  ];

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
              SizedBox(height: deviceHeight * 0.05),
              isLoading
                  ? SizedBox(
                      height: deviceHeight * 0.3,
                      child: Column(
                        children: [
                          Expanded(child: Container()),
                          LogoLoading(deviceHeight),
                        ],
                      ))
                  : Column(
                      children: [
                        const PercentStatusWidget(
                          label: 'Present %',
                          value: '75.0%',
                          labelColor: Colors.black,
                          valueColor: Colors.green,
                        ),
                        SizedBox(height: deviceHeight * 0.01),
                        const PercentStatusWidget(
                          label: 'Attended Days',
                          value: '10/13',
                          labelColor: Colors.black,
                          valueColor: Colors.green,
                        )
                      ],
                    )
            ],
          )
        ],
      ),
    );
  }
}
