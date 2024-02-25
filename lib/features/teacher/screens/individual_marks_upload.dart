// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/common/widgets/row_head_disc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class StudentAttendanceData {
  final String rollNo;
  final String name;
  final String? propic;

  StudentAttendanceData(this.rollNo, this.name, this.propic);
}

class NewUploadMarks extends StatefulWidget {
  final String currentYear;
  final String classId;
  final String subId;
  final Map<String, dynamic> examData;

  const NewUploadMarks({
    Key? key,
    required this.currentYear,
    required this.classId,
    required this.subId,
    required this.examData,
  }) : super(key: key);

  @override
  State<NewUploadMarks> createState() => _NewUploadMarksState();
}

class _NewUploadMarksState extends State<NewUploadMarks> {
  bool isLoading = false;
  bool addingAttendance = false;
  List<StudentAttendanceData> students = [];
  List<TextEditingController> groupValue = [];

  void _toggleSwitch(bool value) {
    setState(() {
      groupValue = List<TextEditingController>.generate(
        students.length,
        (index) => TextEditingController(),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    // Add static data (for demonstration purposes)
    students = [
      StudentAttendanceData('001', 'John Doe', null),
      StudentAttendanceData('002', 'Jane Doe', null),
      // Add more static data as needed
    ];

    groupValue = List<TextEditingController>.generate(
      students.length,
      (index) => TextEditingController(),
    );
  }

  submitAttendance() async {
    setState(() {
      addingAttendance = true;
    });

    try {
      var studentArray = [];

      for (int i = 0; i < students.length; i++) {
        studentArray.add({
          "roll": students[i].rollNo,
          "marks": groupValue[i].text.trim(),
        });
      }

      // Simulating API call
      await Future.delayed(const Duration(seconds: 2));

      // Print data for testing
      print('Student Marks: $studentArray');

      print('success');
      Fluttertoast.showToast(msg: 'Saved Successfully !');

      Navigator.pop(context);
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: 'Failed to save, Try again!');
    }

    setState(() {
      addingAttendance = false;
    });
  }

  updateTime() async {
    // Implement your logic for updating time
    // For now, this function is a placeholder
  }

  @override
  void dispose() {
    students.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: SubPageAppBar(context, 'Upload Marks'),
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
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Max Marks : ',
                              style: AppTextStyles.sliderText
                                  .copyWith(fontSize: 14),
                            ),
                            Text(
                              '${widget.examData['marks']}',
                              style: AppTextStyles.sliderText
                                  .copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                    border: Border.all(color: Colors.black, width: 0.5)),
                child: addingAttendance
                    ? Center(
                        child: Text(
                          'Adding Marks. Please Wait...',
                          style: GoogleFonts.poppins(),
                        ),
                      )
                    : isLoading
                        ? const CircularProgressIndicator() // Loading widget
                        : students.isEmpty
                            ? const Center(
                                child: Text('No Students Found'),
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
                                              students[index].name,
                                              textAlign: TextAlign.start,
                                              style: AppTextStyles.heading2,
                                            ),
                                            Text(
                                              'Roll No: ${students[index].rollNo}',
                                              style: AppTextStyles.heading2
                                                  .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
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
                                                          .propic ==
                                                      null
                                                  ? const NetworkImage(
                                                      'https://firebasestorage.googleapis.com/v0/b/lmsapp-5ab03.appspot.com/o/photo_6336711903350470680_x.jpg?alt=media&token=cb008091-1921-40ee-b133-e7d0bd42d83a')
                                                  : NetworkImage(
                                                      students[index].propic!),
                                              child:
                                                  students[index].propic == null
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
                                          width: deviceWidth * 0.3,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: TextField(
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(),
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: groupValue[index],
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Enter Marks',
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
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
                    onPressed: () {
                      _toggleSwitch(true);
                    },
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

// void main() {
//   runApp(MaterialApp(
//     home: NewUploadMarks(
//       currentYear: '2022',
//       classId: 'Class 10',
//       subId: 'Math',
//       examData: {'name': 'Final Exam', 'marks': 100},
//     ),
//   ));
// }
