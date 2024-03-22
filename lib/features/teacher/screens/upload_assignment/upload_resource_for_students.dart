import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/teacher/screens/upload_assignment/give_assigment.dart';
import 'package:erp_app/features/teacher/screens/upload_assignment/view_assignment.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class UploadResourceForStudentScreen extends StatefulWidget {
  final String sectionId;
  final String classId;
  final String subId;
  final String subName;
  const UploadResourceForStudentScreen({
    super.key,
    required this.classId,
    required this.sectionId,
    required this.subId,
    required this.subName,
  });

  @override
  State<UploadResourceForStudentScreen> createState() =>
      _UploadResourceForStudentScreenState();
}

class _UploadResourceForStudentScreenState
    extends State<UploadResourceForStudentScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(context, "Assignment"),
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
                SizedBox(
                  height: deviceHeight * 0.05,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: GiveAssignmentScreen(
                                sectionId: widget.sectionId,
                                classId: widget.classId,
                                subId: widget.subId,
                                subName: widget.subName,
                              ),
                              type: PageTransitionType.fade,
                              alignment: Alignment.lerp(
                                Alignment.centerLeft,
                                Alignment.centerLeft,
                                0.5,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: deviceWidth / 2 - 20,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFF36FF32),
                            border: Border.all(color: const Color(0xFFDADADA)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Give Assignments",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.heading1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: ViewAssignmentScreeb(
                                sectionId: widget.sectionId,
                                subId: widget.subId,
                                subname: widget.subName,
                                who: "Teacher",
                              ),
                              type: PageTransitionType.fade,
                              alignment: Alignment.lerp(
                                Alignment.centerLeft,
                                Alignment.centerLeft,
                                0.5,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: deviceWidth / 2 - 20,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A72FF),
                            border: Border.all(color: const Color(0xFFDADADA)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "View Submissions",
                              style: AppTextStyles.heading1
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
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
