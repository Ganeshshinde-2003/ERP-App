import 'package:erp_app/constant/widgets/students/menu_widget.dart';
import 'package:erp_app/constant/widgets/students/small_dashboard.dart';
import 'package:flutter/material.dart';

class WidgetDataStudent {
  late double deviceHeight;
  late double deviceWidth;

  WidgetDataStudent(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
  }

  List<Widget> get menuItems => [
        SmallDashboard(
          'assets/small-dashboard-abstract.png',
          'assets/attendance.png',
          deviceHeight,
          'Attendance',
        ),
        SmallDashboard(
          'assets/small-dashboard-abstract2.png',
          'assets/schedule.png',
          deviceHeight,
          "Today's Classes",
        ),
        SmallDashboard(
          'assets/small-dashboard-abstract4.png',
          'assets/homeworks.png',
          deviceHeight,
          'Homeworks',
        ),
        SmallDashboard(
          'assets/small-dashboard-abstract3.png',
          'assets/track-van.png',
          deviceHeight,
          'Track Van',
        ),
      ];

  List<Widget> get fullMenuItems => [
        FullMenuWidget(
          deviceHeight,
          deviceWidth,
          true,
          'assets/grades.png',
          'Grades',
        ),
        FullMenuWidget(
          deviceHeight,
          deviceWidth,
          true,
          'assets/folder.png',
          'Resources',
        ),
        FullMenuWidget(
          deviceHeight,
          deviceWidth,
          true,
          'assets/fee-payment.png',
          'Fee Payment',
        ),
        FullMenuWidget(
          deviceHeight,
          deviceWidth,
          false,
          'assets/ai.png',
          'Doubts with AI',
        ),
        FullMenuWidget(
          deviceHeight,
          deviceWidth,
          false,
          'assets/attachements.png',
          'Events',
        ),
        FullMenuWidget(
          deviceHeight,
          deviceWidth,
          true,
          'assets/assignment.png',
          'Assignments',
        ),
        FullMenuWidget(
          deviceHeight,
          deviceWidth,
          true,
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
          true,
          'assets/grades.png',
          'Leave Application',
        ),
      ];
}
