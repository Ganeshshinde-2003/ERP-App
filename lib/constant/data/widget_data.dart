import 'package:erp_app/constant/widgets/students/menu_widget.dart';
import 'package:erp_app/constant/widgets/students/small_dashboard.dart';
import 'package:flutter/material.dart';

class WidgetData {
  late double deviceHeight;
  late double deviceWidth;

  WidgetData(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
  }

  List<Widget> get menuItems => [
        SmallDashboard(
          'assets/small-dashboard-abstract5.png',
          'assets/attendance.png',
          deviceHeight,
          'Put Attendance',
        ),
        SmallDashboard(
          'assets/small-dashboard-abstract2.png',
          'assets/schedule.png',
          deviceHeight,
          "Today's Classes",
        ),
        SmallDashboard(
          'assets/small-dashboard-abstract4.png',
          'assets/attendance.png',
          deviceHeight,
          'My Attendance',
        ),
        SmallDashboard(
          'assets/small-dashboard-abstract3.png',
          'assets/grades.png',
          deviceHeight,
          'Upload Marks',
        ),
      ];

  List<Widget> get fullMenuItems => [
        FullMenuWidget(
          deviceHeight,
          deviceWidth,
          true,
          'assets/homework-red.png',
          'HomeWork',
        ),
        FullMenuWidget(
          deviceHeight,
          deviceWidth,
          true,
          'assets/syllabus.png',
          'Syllabus',
        ),
        FullMenuWidget(
          deviceHeight,
          deviceWidth,
          true,
          'assets/salary.png',
          'My Salary',
        ),
        FullMenuWidget(
          deviceHeight,
          deviceWidth,
          true,
          'assets/study-material.png',
          'Assignment',
        ),
        FullMenuWidget(
          deviceHeight,
          deviceWidth,
          false,
          'assets/leave-application.png',
          'Leave Application',
        ),
        FullMenuWidget(
          deviceHeight,
          deviceWidth,
          false,
          'assets/student-birthdays.png',
          'Student Birthdays',
        ),
        FullMenuWidget(
          deviceHeight,
          deviceWidth,
          false,
          'assets/message.png',
          'Group Chat',
        ),
        FullMenuWidget(
          deviceHeight,
          deviceWidth,
          false,
          'assets/personal_msg.png',
          'Personal Message',
        ),
        FullMenuWidget(
          deviceHeight,
          deviceWidth,
          false,
          'assets/folder.png',
          'Upload Resources',
        ),
        FullMenuWidget(
          deviceHeight,
          deviceWidth,
          true,
          'assets/attachements.png',
          'Events',
        ),
      ];
}
