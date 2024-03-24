import 'package:erp_app/constant/models/master_model.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/features/teacher/screens/individual_marks_upload.dart';
import 'package:erp_app/features/teacher/screens/resources_screen.dart';
import 'package:erp_app/features/teacher/screens/syllabus_screens/syllabus_details_page.dart';
import 'package:erp_app/features/teacher/screens/upload_assignment/upload_resource_for_students.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MarkUploadSubjectWiseViewWidget extends StatelessWidget {
  final String whoCalling;
  final List<Subject> items;
  final String currentYear;
  final Map<String, dynamic>? examId;
  final String sectionId;
  final String isRes;
  final String isSyl;

  const MarkUploadSubjectWiseViewWidget({
    super.key,
    required this.items,
    required this.currentYear,
    required this.whoCalling,
    required this.sectionId,
    required this.examId,
    required this.isRes,
    required this.isSyl,
  });

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    return items.isNotEmpty
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 25.0,
              crossAxisSpacing: 12.0,
              childAspectRatio: 1.9,
              crossAxisCount: 2,
            ),
            itemCount: items.length,
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
                      child: isSyl == "yes"
                          ? SyallabusDetailsScreen(
                              classID: items[index].classId,
                              subId: items[index].id,
                              editAble: true,
                              who: 'teacher',
                              subName: items[index].subjectName,
                            )
                          : isRes == "yes"
                              ? ResourceByClassAndSub(
                                  subName: items[index].subjectName,
                                  classId: items[index].classId,
                                  subId: items[index].id,
                                  whoIs: "Teacher",
                                )
                              : whoCalling == "subjects-for-resources"
                                  ? UploadResourceForStudentScreen(
                                      classId: items[index].classId,
                                      sectionId: sectionId,
                                      subId: items[index].id,
                                      subName: items[index].subjectName,
                                    )
                                  : NewUploadMarks(
                                      currentYear: currentYear,
                                      classId: items[index].subjectName,
                                      subId: items[index].id,
                                      sectionId: sectionId,
                                      examId: examId!['scheduleId'],
                                      examData: {
                                        'name': examId!['name'],
                                        'marks': examId!['passingMarks']
                                      },
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          items[index].subjectName,
                          style:
                              AppTextStyles.sliderText.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : NoDataFound(
            deviceHeight,
            'assets/loading2.json',
          );
  }
}
