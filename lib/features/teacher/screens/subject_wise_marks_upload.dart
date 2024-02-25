import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/common/widgets/class_past_button.dart';
import 'package:erp_app/features/common/widgets/subject_wise_list_view.dart';
import 'package:erp_app/features/teacher/screens/individual_marks_upload.dart';
import 'package:erp_app/features/teacher/screens/past_marks.dart';
import 'package:flutter/material.dart';

class SubjectWiseMarksUpload extends StatefulWidget {
  final String classname;
  const SubjectWiseMarksUpload({super.key, required this.classname});

  @override
  State<SubjectWiseMarksUpload> createState() => _SubjectWiseMarksUploadState();
}

class _SubjectWiseMarksUploadState extends State<SubjectWiseMarksUpload> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = true;
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(context, 'Upload Marks'),
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
                  title: "Select Exam",
                  buttonText: "Past Marks",
                  onPressed: PastMarksScreen(),
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
                        : SubjectWiseMarkView(
                            items: const [
                              {"class": "9A", "name": "Fa1", "marks": 20},
                              {"class": "9A", "name": "Fa2", "marks": 20},
                              {"class": "9A", "name": "Fa3", "marks": 20},
                            ],
                            currentYear: '2022',
                            onTap: (classId, currentYear) {
                              return NewUploadMarks(
                                currentYear: currentYear,
                                classId: classId,
                                subId: "SUB01",
                                examData: const {
                                  'name': 'Final Exam',
                                  'marks': 100
                                },
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
