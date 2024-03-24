import 'package:erp_app/constant/widgets/students/menu_widget.dart';
import 'package:erp_app/constant/widgets/students/small_dashboard.dart';
import 'package:erp_app/features/common/eventscreens/events_page.dart';
import 'package:erp_app/features/student/screens/ai_assist_page.dart';
import 'package:erp_app/features/student/screens/attendance_page.dart';
import 'package:erp_app/features/student/screens/fee_history_page.dart';
import 'package:erp_app/features/student/screens/subject_wise_view.dart';
import 'package:erp_app/features/student/screens/timetabel_page.dart';
import 'package:erp_app/features/student/screens/vanlive_tracking.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class WidgetDataStudent {
  late double deviceHeight;
  late double deviceWidth;
  late BuildContext context;

  WidgetDataStudent(this.context)
      : deviceHeight = MediaQuery.of(context).size.height,
        deviceWidth = MediaQuery.of(context).size.width;

  void openPage(Widget page) {
    Navigator.push(
      context,
      PageTransition(
        child: page,
        type: PageTransitionType.fade,
        alignment: Alignment.lerp(
          Alignment.centerLeft,
          Alignment.centerLeft,
          0.5,
        ),
      ),
    );
  }

  List<Widget> get menuItems => [
        GestureDetector(
          onTap: () => openPage(const StudentAttendancePageScreen()),
          child: SmallDashboard(
            'assets/small-dashboard-abstract.png',
            'assets/attendance.png',
            deviceHeight,
            'Attendance',
          ),
        ),
        GestureDetector(
          onTap: () => openPage(const StudentTimeTablePageScreen(
            who: 'Student',
          )),
          child: SmallDashboard(
            'assets/small-dashboard-abstract2.png',
            'assets/schedule.png',
            deviceHeight,
            "Today's Classes",
          ),
        ),
        GestureDetector(
          onTap: () => openPage(const HomeWorkSubjectScreen(who: "work")),
          child: SmallDashboard(
            'assets/small-dashboard-abstract4.png',
            'assets/study-material.png',
            deviceHeight,
            'Assignment',
          ),
        ),
        GestureDetector(
          onTap: () => openPage(const VanLiveTrackingScreen()),
          child: SmallDashboard(
            'assets/small-dashboard-abstract3.png',
            'assets/track-van.png',
            deviceHeight,
            'Track Van',
          ),
        ),
      ];

  List<Widget> get fullMenuItems => [
        GestureDetector(
          onTap: () => openPage(const StudentAttendancePageScreen()),
          child: FullMenuWidget(
            deviceHeight,
            deviceWidth,
            false,
            'assets/grades.png',
            'Grades',
          ),
        ),
        GestureDetector(
          onTap: () => openPage(const HomeWorkSubjectScreen(who: "syl")),
          child: FullMenuWidget(
            deviceHeight,
            deviceWidth,
            false,
            'assets/syllabus.png',
            'Syllabus',
          ),
        ),
        GestureDetector(
          onTap: () => openPage(const HomeWorkSubjectScreen(who: "res")),
          child: FullMenuWidget(
            deviceHeight,
            deviceWidth,
            false,
            'assets/folder.png',
            'Resources',
          ),
        ),
        GestureDetector(
          onTap: () => openPage(const FeeHistoryScreen()),
          child: FullMenuWidget(
            deviceHeight,
            deviceWidth,
            false,
            'assets/fee-payment.png',
            'Fee Payment',
          ),
        ),
        GestureDetector(
          onTap: () => openPage(const ChatGPTScreen()),
          child: FullMenuWidget(
            deviceHeight,
            deviceWidth,
            false,
            'assets/ai.png',
            'Doubts with AI',
          ),
        ),
        GestureDetector(
          onTap: () => openPage(const EventsPageScreen(who: "Student")),
          child: FullMenuWidget(
            deviceHeight,
            deviceWidth,
            false,
            'assets/attachements.png',
            'Events',
          ),
        ),
        // GestureDetector(
        //   onTap: () => openPage(const StudentAttendancePageScreen()),
        //   child: FullMenuWidget(
        //     deviceHeight,
        //     deviceWidth,
        //     true,
        //     'assets/assignment.png',
        //     'Assignments',
        //   ),
        // ),
        // GestureDetector(
        //   onTap: () => openPage(const StudentAttendancePageScreen()),
        //   child: FullMenuWidget(
        //     deviceHeight,
        //     deviceWidth,
        //     true,
        //     'assets/message.png',
        //     'Group Chat',
        //   ),
        // ),
        // GestureDetector(
        //   onTap: () => openPage(const StudentAttendancePageScreen()),
        //   child: FullMenuWidget(
        //     deviceHeight,
        //     deviceWidth,
        //     false,
        //     'assets/personal_msg.png',
        //     'Personal Message',
        //   ),
        // ),
        // GestureDetector(
        //   onTap: () => openPage(const StudentAttendancePageScreen()),
        //   child: FullMenuWidget(
        //     deviceHeight,
        //     deviceWidth,
        //     true,
        //     'assets/grades.png',
        //     'Leave Application',
        //   ),
        // ),
      ];
}
