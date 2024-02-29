import 'package:erp_app/constant/models/master_model.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/common/widgets/class_past_button.dart';
import 'package:erp_app/features/common/widgets/subject_wise_list_view.dart';
import 'package:erp_app/features/teacher/controller/attendance_controller.dart';
import 'package:erp_app/features/teacher/screens/individual_class_attendacne.dart';
import 'package:erp_app/features/teacher/screens/individual_marks_upload.dart';
import 'package:erp_app/features/teacher/screens/past_marks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubjectWiseMarksUpload extends ConsumerStatefulWidget {
  final String classID;
  final String callingWho;
  const SubjectWiseMarksUpload({
    super.key,
    required this.classID,
    required this.callingWho,
  });

  @override
  ConsumerState<SubjectWiseMarksUpload> createState() =>
      _SubjectWiseMarksUploadState();
}

class _SubjectWiseMarksUploadState
    extends ConsumerState<SubjectWiseMarksUpload> {
  List<Section>? sectionList;

  @override
  void initState() {
    super.initState();
    loadSectionList();
  }

  Future<void> loadSectionList() async {
    sectionList = await ref
        .read(masterDataUtilControllerProvider)
        .getMasterSectionData(widget.classID);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = true;
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(
        context,
        widget.callingWho == "marks" ? 'Upload Marks' : "Attendance",
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
                  title: "Select Section",
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
                            whoCalling: widget.callingWho,
                            items: sectionList ?? [],
                            currentYear: '2022',
                            onTap: (classId, currentYear) {
                              return widget.callingWho == "marks"
                                  ? NewUploadMarks(
                                      currentYear: currentYear,
                                      classId: classId,
                                      subId: "SUB01",
                                      examData: const {
                                        'name': 'Final Exam',
                                        'marks': 100
                                      },
                                    )
                                  : IndividualClassAttendace(
                                      classId: classId,
                                      currentYear: currentYear,
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
