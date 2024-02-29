import 'package:erp_app/constant/models/master_model.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/features/teacher/screens/individual_marks_upload.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MarkUploadSubjectWiseViewWidget extends StatelessWidget {
  final String whoCalling;
  final List<Subject> items;
  final String currentYear;

  const MarkUploadSubjectWiseViewWidget({
    super.key,
    required this.items,
    required this.currentYear,
    required this.whoCalling,
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
                      child: NewUploadMarks(
                        currentYear: currentYear,
                        classId: items[index].subjectName,
                        subId: "SUB01",
                        examData: const {'name': 'Final Exam', 'marks': 100},
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
