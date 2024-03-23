import 'package:erp_app/constant/models/get_subject_model.dart';
import 'package:erp_app/constant/models/student_login_model.dart';
import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/common/widgets/class_past_button.dart';
import 'package:erp_app/features/student/controller/howewoek_controller.dart';
import 'package:erp_app/features/teacher/screens/past_marks.dart';
import 'package:erp_app/features/teacher/screens/resources_screen.dart';
import 'package:erp_app/features/teacher/screens/syllabus_screens/syllabus_details_page.dart';
import 'package:erp_app/features/teacher/screens/upload_assignment/view_assignment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

class HomeWorkSubjectScreen extends ConsumerStatefulWidget {
  final String who;
  const HomeWorkSubjectScreen({Key? key, required this.who}) : super(key: key);

  @override
  ConsumerState<HomeWorkSubjectScreen> createState() =>
      _HomeWorkSubjectScreenState();
}

class _HomeWorkSubjectScreenState extends ConsumerState<HomeWorkSubjectScreen> {
  SubjectResponse? subjectData;
  String? sectionId;
  String? classId;

  @override
  void initState() {
    fetchSubjects();
    super.initState();
  }

  void fetchSubjects() async {
    SharedStoreData sharedStoreData = SharedStoreData();
    subjectData = await ref
        .read(homeWorkControllerProvider)
        .fetchSubjectforHoweWork(context);

    StudentLoginModel? data =
        await sharedStoreData.loadStudentFromPreferences();
    sectionId = data?.data.admissionDetails.sectionID.id;
    classId = data?.data.admissionDetails.classID.id;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(
        context,
        widget.who == "res"
            ? "Resources"
            : widget.who == "work"
                ? 'Homework'
                : "Syllabus",
      ),
      body: Stack(
        children: [
          BottomImageBar(
            deviceWidth: deviceWidth,
            color: "Green",
          ),
          Column(
            children: [
              SizedBox(
                width: deviceWidth * 0.8,
                child: const ReusableClassButtonWidget(
                  title: "Select Subject",
                  buttonText: "Past Assignment",
                  onPressed: PastMarksScreen(),
                ),
              ),
              SizedBox(
                width: deviceWidth * 0.8,
                child: const Divider(thickness: 1),
              ),
              if (subjectData == null)
                Expanded(
                  child: Center(
                    child: NoDataFound(deviceHeight, 'assets/loading1.json'),
                  ),
                ),
              if (subjectData != null)
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(20.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 1.9,
                    ),
                    itemCount: subjectData!.data.length,
                    itemBuilder: (context, index) {
                      final subject = subjectData!.data[index];
                      return GestureDetector(
                        onTap: () {
                          widget.who == "syl"
                              ? Navigator.push(
                                  context,
                                  PageTransition(
                                    child: SyallabusDetailsScreen(
                                      who: 'Student',
                                      classID: classId!,
                                      subId: subject.id,
                                      editAble: false,
                                      subName: subject.subjectName,
                                    ),
                                    type: PageTransitionType.fade,
                                    alignment: Alignment.lerp(
                                      Alignment.centerLeft,
                                      Alignment.centerLeft,
                                      0.5,
                                    ),
                                  ),
                                )
                              : widget.who == 'work'
                                  ? Navigator.push(
                                      context,
                                      PageTransition(
                                        child: ViewAssignmentScreeb(
                                          sectionId: sectionId!,
                                          subId: subject.id,
                                          subname: subject.subjectName,
                                          who: "Student",
                                        ),
                                        type: PageTransitionType.fade,
                                        alignment: Alignment.lerp(
                                          Alignment.centerLeft,
                                          Alignment.centerLeft,
                                          0.5,
                                        ),
                                      ),
                                    )
                                  : Navigator.push(
                                      context,
                                      PageTransition(
                                        child: ResourceByClassAndSub(
                                          subName: subject.subjectName,
                                          classId: classId!,
                                          subId: subject.id,
                                          whoIs: "student",
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: Text(
                              subject.subjectName,
                              style: AppTextStyles.heading1,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
