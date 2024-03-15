import 'package:erp_app/constant/models/master_model.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/common/widgets/class_past_button.dart';
import 'package:erp_app/features/common/widgets/mark_upload_subjectwise_view.dart';
import 'package:erp_app/features/common/widgets/subject_wise_list_view.dart';
import 'package:erp_app/features/teacher/controller/attendance_controller.dart';
import 'package:erp_app/features/teacher/screens/past_marks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubjectWiseMarksUpload extends ConsumerStatefulWidget {
  final Map<String, dynamic>? examScheduleData;
  final String classID;
  final String callingWho;
  final String sectionId;
  const SubjectWiseMarksUpload({
    super.key,
    required this.classID,
    required this.callingWho,
    this.examScheduleData,
    required this.sectionId,
  });

  @override
  ConsumerState<SubjectWiseMarksUpload> createState() =>
      _SubjectWiseMarksUploadState();
}

class _SubjectWiseMarksUploadState
    extends ConsumerState<SubjectWiseMarksUpload> {
  List<Section>? sectionList;
  List<Subject>? subjectList;

  @override
  void initState() {
    super.initState();
    loadSectionList();
  }

  Future<void> loadSectionList() async {
    if (widget.callingWho == "marks" ||
        widget.callingWho == "attendance" ||
        widget.callingWho == "upload-resource") {
      sectionList = await ref
          .read(masterDataUtilControllerProvider)
          .getMasterSectionData(widget.classID);
    } else {
      subjectList = await ref
          .read(masterDataUtilControllerProvider)
          .getMasterSubjectData(widget.classID);
    }
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
        widget.callingWho == "upload-resource" ||
                widget.callingWho == "subjects-for-resources"
            ? "Assignment"
            : widget.callingWho == "marks" || widget.callingWho == "subjects"
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
                ReusableClassButtonWidget(
                  title: widget.callingWho == "subjects" ||
                          widget.callingWho == "subjects-for-resources"
                      ? "Select Subject"
                      : "Select Section",
                  buttonText: "Past Marks",
                  onPressed: const PastMarksScreen(),
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
                        : widget.callingWho == "subjects" ||
                                widget.callingWho == "subjects-for-resources"
                            ? MarkUploadSubjectWiseViewWidget(
                                items: subjectList ?? [],
                                currentYear: '2024',
                                whoCalling: widget.callingWho,
                                sectionId: widget.sectionId,
                              )
                            : SubjectWiseMarkView(
                                whoCalling: widget.callingWho,
                                items: sectionList ?? [],
                                currentYear: '2022',
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
