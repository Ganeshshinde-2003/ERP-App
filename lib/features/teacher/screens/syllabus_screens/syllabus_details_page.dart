// ignore_for_file: use_build_context_synchronously

import 'package:erp_app/constant/models/syllabus_model.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/teacher/controller/syllabus_controller.dart';
import 'package:erp_app/features/teacher/screens/syllabus_screens/chapter_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

class SyallabusDetailsScreen extends ConsumerStatefulWidget {
  final String classID;
  final String subId;
  final bool editAble;
  final String subName;
  final String who;
  const SyallabusDetailsScreen({
    Key? key,
    required this.classID,
    required this.subId,
    required this.editAble,
    required this.subName,
    required this.who,
  }) : super(key: key);

  @override
  ConsumerState<SyallabusDetailsScreen> createState() =>
      _SyallabusDetailsScreenState();
}

class _SyallabusDetailsScreenState
    extends ConsumerState<SyallabusDetailsScreen> {
  SyllabusResponse? syllabusResponseData;

  void fetchSyllabus() async {
    syllabusResponseData =
        await ref.read(syllabusControllerProvider).fetchSyllabus(
              context: context,
              classID: widget.classID,
              subID: widget.subId,
              who: widget.who,
            );
    setState(() {});
  }

  void updateSyllabusStatus(String syllabusID, String status) async {
    await ref.read(syllabusControllerProvider).updateSyllabusStatus(
          context: context,
          syllabusID: syllabusID,
          status: status,
        );
    fetchSyllabus();
    Navigator.pop(context);
  }

  void _showUpdateDialog(Syllabus syllabus) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Update Syllabus Status',
          style: AppTextStyles.heading1,
        ),
        content: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => updateSyllabusStatus(syllabus.id, "in_progress"),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "In Progress",
                    style: AppTextStyles.buttonText.copyWith(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () => updateSyllabusStatus(syllabus.id, "completed"),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFF03E627),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Completed",
                    style: AppTextStyles.buttonText.copyWith(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () => updateSyllabusStatus(syllabus.id, "pending"),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFFFF6651),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Pending",
                    style: AppTextStyles.buttonText.copyWith(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    fetchSyllabus();
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
          if (syllabusResponseData == null ||
              syllabusResponseData!.data.syllabus.isEmpty)
            Center(
              child: NoDataFound(
                deviceHeight,
                'assets/loading1.json',
                text: "No Syllabus Found",
              ),
            ),
          if (syllabusResponseData != null &&
              syllabusResponseData!.data.syllabus.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(
                bottom: 130,
                top: 30,
                left: 20,
                right: 20,
              ),
              padding: const EdgeInsets.only(top: 30, bottom: 10),
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
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: syllabusResponseData!.data.syllabus.length,
                itemBuilder: (context, index) {
                  final syllabus = syllabusResponseData!.data.syllabus[index];
                  Color containerColor = const Color(0xFFFF6651);
                  if (syllabus.status == "completed") {
                    containerColor = const Color(0xFF03E627);
                  } else if (syllabus.status == "in_progress") {
                    containerColor = Colors.yellow;
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: ChapterDetailsPageScreen(syllabus: syllabus),
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
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 1.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xFF4094A8),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              syllabus.chapterNo.toString(),
                              style: AppTextStyles.buttonText,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  syllabus.title,
                                  style: AppTextStyles.heading1,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              if (widget.editAble) {
                                _showUpdateDialog(syllabus);
                              }
                            },
                            child: Container(
                              width: 80,
                              height: 40,
                              decoration: BoxDecoration(
                                color: containerColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                syllabus.status == "in_progress"
                                    ? "In Progress"
                                    : syllabus.status == "completed"
                                        ? "Completed"
                                        : "Pending",
                                style: AppTextStyles.buttonText
                                    .copyWith(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
