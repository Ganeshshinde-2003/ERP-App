import 'package:erp_app/constant/models/exam_result_subject_modeld.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/student/controller/fee_history_controller.dart';

class GradesBySubjects extends ConsumerStatefulWidget {
  final String subId;
  final String subName;
  const GradesBySubjects({
    Key? key,
    required this.subId,
    required this.subName,
  }) : super(key: key);

  @override
  ConsumerState<GradesBySubjects> createState() => _GradesBySubjectsState();
}

class _GradesBySubjectsState extends ConsumerState<GradesBySubjects> {
  ExamResultSubject? examResultSubject;

  void fetchExamsResults() async {
    examResultSubject =
        await ref.read(feeHistoryControllerProvider).fetchExamsResulsBySubject(
              context,
              widget.subId,
            );
    setState(() {});
  }

  @override
  void initState() {
    fetchExamsResults();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(context, widget.subName),
      body: Stack(
        children: [
          BottomImageBar(deviceWidth: deviceWidth, color: "Green"),
          if (examResultSubject == null || examResultSubject!.data.isEmpty)
            Container(
              margin: const EdgeInsets.only(
                bottom: 130,
                top: 30,
                left: 20,
                right: 20,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              height: deviceHeight,
              child: Center(
                child: NoDataFound(
                  deviceHeight,
                  'assets/loading1.json',
                  text: "No Exams Found",
                ),
              ),
            ),
          if (examResultSubject != null)
            Container(
              margin: const EdgeInsets.only(
                bottom: 130,
                top: 30,
                left: 20,
                right: 20,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              height: deviceHeight,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Passing Marks: ${examResultSubject?.data.first.examSchedule.examType.passingMarks}',
                      style: AppTextStyles.heading1,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Colors.black),
                                  ),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Exam Name',
                                  style: AppTextStyles.heading1,
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Colors.black),
                                  ),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Obtained Marks',
                                  style: AppTextStyles.heading1,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: examResultSubject!.data.map((examData) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          right:
                                              BorderSide(color: Colors.black),
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        examData.examSchedule.examType
                                            .examCategory.examCategory,
                                        style: AppTextStyles.bodyText.copyWith(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        '${examData.obtainedMarks}',
                                        style: AppTextStyles.bodyText.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
