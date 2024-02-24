import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/common/widgets/class_past_button.dart';
import 'package:erp_app/features/common/widgets/put_attendance_list.dart';
import 'package:erp_app/features/teacher/screens/individual_class_attendacne.dart';
import 'package:erp_app/features/teacher/screens/past_attendance.dart';
import 'package:flutter/material.dart';

class TeacherPutAttendance extends StatefulWidget {
  const TeacherPutAttendance({super.key});

  @override
  State<TeacherPutAttendance> createState() => _TeacherPutAttendanceState();
}

class _TeacherPutAttendanceState extends State<TeacherPutAttendance> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = true;
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(context, 'Attendance'),
      body: Stack(
        children: [
          BottomImageBar(
            deviceWidth: deviceWidth,
            color: "Green",
          ),
          SizedBox(
            height: deviceHeight,
            width: deviceWidth,
            child: Column(
              children: [
                const ReusableClassButtonWidget(
                  title: "Select Class and Subject",
                  buttonText: "Past Attendance",
                  onPressed: PastAttendaceScreen(),
                ),
                SizedBox(
                  width: deviceWidth * 0.8,
                  child: const Divider(thickness: 1),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: !isLoading
                        // ignore: dead_code
                        ? NoDataFound(deviceHeight, 'assets/loading2.json')
                        // ignore: dead_code
                        : PutAttendanceListView(
                            items: const ['ClassA', 'ClassB', 'ClassC'],
                            currentYear: '2022',
                            onTap: (classId, currentYear) {
                              return IndividualClassAttendace(
                                classId: classId,
                                currentYear: currentYear,
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
