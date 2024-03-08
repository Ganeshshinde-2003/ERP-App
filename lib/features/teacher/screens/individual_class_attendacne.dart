// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:erp_app/constant/models/student_attendace_model.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/constant/widgets/snack_bar.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/common/widgets/row_head_disc.dart';
import 'package:erp_app/features/teacher/controller/student_fetching_for_attendance_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class IndividualClassAttendace extends ConsumerStatefulWidget {
  final String currentYear;
  final String classId;
  final String sectionId;

  const IndividualClassAttendace({
    Key? key,
    required this.currentYear,
    required this.classId,
    required this.sectionId,
  }) : super(key: key);

  @override
  ConsumerState<IndividualClassAttendace> createState() =>
      _IndividualClassAttendaceState();
}

class _IndividualClassAttendaceState
    extends ConsumerState<IndividualClassAttendace> {
  bool isLoading = false;
  bool addingAttendance = false;
  List<StudentData> students = [];
  late List<bool> groupValue;
  bool _value = true;

  void _toggleSwitch(bool value) {
    setState(() {
      _value = value;
      if (!_value) {
        groupValue = List<bool>.filled(students.length, false);
      } else {
        groupValue = List<bool>.filled(students.length, true);
      }
    });
  }

  void getData() async {
    try {
      setState(() {
        isLoading = true;
      });

      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      // Fetch data
      students = await ref
          .read(putStudentAttendanceControllerProvider)
          .fetchStudentAttendanceData(context, widget.sectionId, currentDate);

      await processData(students);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> processData(data) async {
    if (data.isNotEmpty) {
      groupValue = List<bool>.filled(data.length, true);

      for (int i = 0; i < data.length; i++) {
        groupValue[i] = data[i].attendanceStatus;
      }
    } else {
      groupValue = [];
    }
  }

  void submitAttendance() async {
    setState(() {
      addingAttendance = true;
    });

    try {
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      List<String> absentStudents = [];
      List<String> presentStudents = [];

      for (int i = 0; i < students.length; i++) {
        if (groupValue[i]) {
          presentStudents.add(students[i].id.toString());
        } else {
          absentStudents.add(students[i].id.toString());
        }
      }

      Map<String, dynamic> attendanceData = {
        'date': currentDate,
        'sectionId': widget.sectionId.toString(),
        'absent': absentStudents,
        'present': presentStudents,
      };
      await ref
          .read(putStudentAttendanceControllerProvider)
          .saveAttendanceData(attendanceData, context);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to save, Try again!');
    }

    setState(() {
      addingAttendance = false;
    });
  }

  void resetAttendance() {
    setState(() {
      _value = true;
      if (students.isNotEmpty) {
        groupValue = List<bool>.filled(students.length, true);
      } else {
        groupValue = [];
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: SubPageAppBar(context, 'Attendance'),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RowHeadDiscWidget(head: "Class", disc: widget.classId),
                        RowHeadDiscWidget(
                          head: "Date",
                          disc: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Absent',
                        style: AppTextStyles.sliderText.copyWith(fontSize: 14),
                      ),
                      const SizedBox(width: 2),
                      CupertinoSwitch(value: _value, onChanged: _toggleSwitch),
                      const SizedBox(width: 2),
                      Text(
                        'Present',
                        style: AppTextStyles.sliderText.copyWith(fontSize: 14),
                      ),
                      const SizedBox(width: 10),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: deviceWidth * 0.8,
            child: const Divider(thickness: 1),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: addingAttendance
                    ? Center(
                        child: Text(
                          'Adding Attendance. Please Wait...',
                          style: GoogleFonts.poppins(),
                        ),
                      )
                    : isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : students.isEmpty
                            ? Center(
                                child: Column(
                                  children: [
                                    NoDataFound(
                                        deviceHeight, "assets/loading2.json"),
                                    Text(
                                      'No Students Found',
                                      style: GoogleFonts.poppins(),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: students.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              textScaleFactor: 1.0,
                                              students[index].studentID.name,
                                              textAlign: TextAlign.start,
                                              style: AppTextStyles.heading2,
                                            ),
                                            Text(
                                              textScaleFactor: 1.0,
                                              'Roll No: ${students[index].studentID.rollNo}',
                                              style: AppTextStyles.heading2
                                                  .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              textScaleFactor: 1.0,
                                              'USN: ${students[index].studentID.rollNo}',
                                              style: AppTextStyles.heading2
                                                  .copyWith(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        leading: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: students[index]
                                                          .studentID
                                                          .name
                                                          .toString() !=
                                                      'null'
                                                  ? const NetworkImage(
                                                      'https://firebasestorage.googleapis.com/v0/b/lmsapp-5ab03.appspot.com/o/photo_6336711903350470680_x.jpg?alt=media&token=cb008091-1921-40ee-b133-e7d0bd42d83a')
                                                  : NetworkImage(students[index]
                                                      .status
                                                      .toString()),
                                              child: students[index]
                                                          .status
                                                          .toString() !=
                                                      'null'
                                                  ? Image.asset(
                                                      'assets/avatar.png')
                                                  : const SizedBox.shrink(),
                                            ),
                                            SizedBox(
                                              height: deviceHeight * 0.003,
                                            ),
                                          ],
                                        ),
                                        trailing: SizedBox(
                                          height: deviceHeight * 0.05,
                                          width: deviceWidth * 0.35,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    groupValue[index] = false;
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: !groupValue[index]
                                                        ? Colors.red
                                                        : Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        textScaleFactor: 1.0,
                                                        "Absent",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Colors.white,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    groupValue[index] = true;
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: groupValue[index]
                                                        ? Colors.greenAccent
                                                        : Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        textScaleFactor: 1.0,
                                                        "Present",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 11,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  );
                                },
                              ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              Row(
                children: [
                  TextButton(
                    onPressed: resetAttendance,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: Text(
                          'Reset',
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: submitAttendance,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue.shade800,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: Text(
                          'Save',
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
