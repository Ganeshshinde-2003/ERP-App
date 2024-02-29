import 'package:erp_app/constant/models/master_model.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/common/widgets/class_past_button.dart';
import 'package:erp_app/features/common/widgets/put_attendance_list.dart';
import 'package:erp_app/features/teacher/controller/attendance_controller.dart';
import 'package:erp_app/features/teacher/screens/past_attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeacherPutAttendance extends ConsumerStatefulWidget {
  const TeacherPutAttendance({Key? key}) : super(key: key);

  @override
  ConsumerState<TeacherPutAttendance> createState() =>
      _TeacherPutAttendanceState();
}

class _TeacherPutAttendanceState extends ConsumerState<TeacherPutAttendance> {
  bool isLoading = true;
  List<Class>? classList;

  @override
  void initState() {
    super.initState();
    loadClassList();
  }

  Future<void> loadClassList() async {
    classList =
        await ref.read(masterDataUtilControllerProvider).getMasterClassData();
    setState(() {
      isLoading = false;
    });
  }

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
            color: "Green",
          ),
          SizedBox(
            height: deviceHeight,
            width: deviceWidth,
            child: Column(
              children: [
                const ReusableClassButtonWidget(
                  title: "Select Class",
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
                    child: isLoading
                        ? NoDataFound(deviceHeight, 'assets/loading2.json')
                        : PutAttendanceListView(
                            whoCalling: "attendance",
                            items: classList ?? [],
                            currentYear: '2022',
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
