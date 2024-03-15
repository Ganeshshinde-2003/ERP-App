import 'package:erp_app/constant/widgets/students/menu_widget.dart';
import 'package:erp_app/constant/widgets/students/small_dashboard.dart';
import 'package:erp_app/features/common/eventscreens/events_page.dart';
import 'package:erp_app/features/student/screens/timetabel_page.dart';
import 'package:erp_app/features/teacher/screens/put_attendance.dart';
import 'package:erp_app/features/teacher/screens/upload_marks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';

class WidgetData {
  late double deviceHeight;
  late double deviceWidth;
  late BuildContext context;

  WidgetData(this.context)
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
          onTap: () => openPage(const TeacherPutAttendance()),
          child: SmallDashboard(
            'assets/small-dashboard-abstract5.png',
            'assets/attendance.png',
            deviceHeight,
            'Put Attendance',
          ),
        ),
        GestureDetector(
          onTap: () => openPage(const StudentTimeTablePageScreen(
            who: "Teacher",
          )),
          child: SmallDashboard(
            'assets/small-dashboard-abstract2.png',
            'assets/schedule.png',
            deviceHeight,
            "Today's Classes",
          ),
        ),
        GestureDetector(
          onTap: () => openPage(const UploadMarksScreen(
            whoiscalling: "upload-resource",
          )),
          child: SmallDashboard(
            'assets/small-dashboard-abstract4.png',
            'assets/study-material.png',
            deviceHeight,
            'Assignment',
          ),
        ),
        GestureDetector(
          onTap: () => openPage(const UploadMarksScreen()),
          child: SmallDashboard(
            'assets/small-dashboard-abstract3.png',
            'assets/grades.png',
            deviceHeight,
            'Upload Marks',
          ),
        ),
      ];

  List<Widget> get fullMenuItems => [
        GestureDetector(
          onTap: () => openPage(const TeacherPutAttendance()),
          child: FullMenuWidget(
            deviceHeight,
            deviceWidth,
            true,
            'assets/syllabus.png',
            'Syllabus',
          ),
        ),
        GestureDetector(
          onTap: () => openPage(const TeacherPutAttendance()),
          child: FullMenuWidget(
            deviceHeight,
            deviceWidth,
            true,
            'assets/salary.png',
            'My Salary',
          ),
        ),
        // GestureDetector(
        //   onTap: () => openPage(const TeacherPutAttendance()),
        //   child: FullMenuWidget(
        //     deviceHeight,
        //     deviceWidth,
        //     false,
        //     'assets/leave-application.png',
        //     'Leave Application',
        //   ),
        // ),
        GestureDetector(
          onTap: () => openPage(const TeacherPutAttendance()),
          child: FullMenuWidget(
            deviceHeight,
            deviceWidth,
            false,
            'assets/student-birthdays.png',
            'Student Birthdays',
          ),
        ),
        // GestureDetector(
        //   onTap: () => openPage(const TeacherPutAttendance()),
        //   child: FullMenuWidget(
        //     deviceHeight,
        //     deviceWidth,
        //     false,
        //     'assets/message.png',
        //     'Group Chat',
        //   ),
        // ),
        // GestureDetector(
        //   onTap: () => openPage(const TeacherPutAttendance()),
        //   child: FullMenuWidget(
        //     deviceHeight,
        //     deviceWidth,
        //     false,
        //     'assets/personal_msg.png',
        //     'Personal Message',
        //   ),
        // ),
        GestureDetector(
          onTap: () => openPage(const UploadMarksScreen(
            whoiscalling: "upload-resource",
          )),
          child: FullMenuWidget(
            deviceHeight,
            deviceWidth,
            false,
            'assets/folder.png',
            'Upload Resources',
          ),
        ),
        GestureDetector(
          onTap: () => openPage(const EventsPageScreen(who: "Teacher")),
          child: FullMenuWidget(
            deviceHeight,
            deviceWidth,
            true,
            'assets/attachements.png',
            'Events',
          ),
        ),
      ];
}
