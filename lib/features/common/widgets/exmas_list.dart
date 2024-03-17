import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/common/widgets/class_past_button.dart';
import 'package:erp_app/features/teacher/controller/get_exams_details_cotroller.dart';
import 'package:erp_app/features/teacher/screens/past_marks.dart';
import 'package:erp_app/features/teacher/screens/subject_wise_marks_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

class ExamsListView extends ConsumerStatefulWidget {
  final String classID;
  final String callingWho;
  final String sectionId;
  const ExamsListView({
    Key? key,
    required this.classID,
    required this.callingWho,
    required this.sectionId,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ExamsListViewState createState() => _ExamsListViewState();
}

class _ExamsListViewState extends ConsumerState<ExamsListView> {
  Map<String, dynamic>? examScheduleData;
  List<Map<String, dynamic>>? uniqueExamNames = [];

  void getExamsDetails() async {
    examScheduleData = await ref
        .read(getExamsDetailsControllerProvider)
        .getExamsDetails(context);

    if (examScheduleData != null) {
      final List<Map<String, dynamic>> allExams =
          examScheduleData!['data'].map<Map<String, dynamic>>((examData) {
        final examCategory = examData['examScheduleID']['examTypeID']
            ['examCatID']['examCategory'] as String?;
        final examScheduleId = examData['examScheduleID']['_id'] as String?;
        return {'name': examCategory ?? "", 'scheduleId': examScheduleId ?? ""};
      }).toList();

      uniqueExamNames = [];
      for (final exam in allExams) {
        bool foundDuplicate = false;
        for (final uniqueExam in uniqueExamNames!) {
          if (exam['name'] == uniqueExam['name']) {
            foundDuplicate = true;
            break;
          }
        }
        if (!foundDuplicate) {
          uniqueExamNames!.add(exam);
        }
      }

      setState(() {});
    } else {}
  }

  @override
  void initState() {
    super.initState();
    getExamsDetails();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(
        context,
        widget.callingWho == "marks" || widget.callingWho == "subjects"
            ? 'Upload Marks'
            : "Attendance",
      ),
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
                if (uniqueExamNames!.isNotEmpty)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 25.0,
                          crossAxisSpacing: 12.0,
                          childAspectRatio: 1.9,
                          crossAxisCount: 2,
                        ),
                        itemCount: uniqueExamNames!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  alignment: Alignment.lerp(
                                    Alignment.centerLeft,
                                    Alignment.centerLeft,
                                    0.5,
                                  ),
                                  child: SubjectWiseMarksUpload(
                                    examScheduleData: uniqueExamNames![index],
                                    classID: widget.classID,
                                    callingWho: "subjects",
                                    sectionId: widget.sectionId,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 1.0,
                                    spreadRadius: 1.0,
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                              child: Center(
                                child: Text(
                                  uniqueExamNames![index]['name'],
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
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
