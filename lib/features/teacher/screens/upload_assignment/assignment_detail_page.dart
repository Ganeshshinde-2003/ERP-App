// ignore_for_file: deprecated_member_use

import 'package:erp_app/constant/models/view_assignment_model.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/pdf_image_viewer_page.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class AssignmentDetailsScreen extends StatefulWidget {
  final AssignmentData assignmentData;
  const AssignmentDetailsScreen({Key? key, required this.assignmentData})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AssignmentDetailsScreenState createState() =>
      _AssignmentDetailsScreenState();
}

class _AssignmentDetailsScreenState extends State<AssignmentDetailsScreen> {
  Future<void> _downloadFile(String url) async {
    Navigator.push(
      context,
      PageTransition(
        child: FileViewerPage(
            appBarName: widget.assignmentData.title,
            fileUrl: widget.assignmentData.uploadedFileUrl),
        type: PageTransitionType.fade,
        alignment:
            Alignment.lerp(Alignment.centerLeft, Alignment.centerLeft, 0.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(context, widget.assignmentData.title),
      body: Stack(
        children: [
          BottomImageBar(
            deviceWidth: deviceWidth,
            color: "Green",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Container(
              margin: const EdgeInsets.only(bottom: 130),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
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
              width: deviceWidth,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.assignmentData.title.toUpperCase(),
                      style: AppTextStyles.heading1.copyWith(fontSize: 30),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.assignmentData.description,
                      style: AppTextStyles.bodyText,
                    ),
                    Text(
                      'Due Date: ${DateFormat('MMMM dd, yyyy').format(widget.assignmentData.dueDate)}',
                      style: AppTextStyles.bodyText,
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        _downloadFile(
                          widget.assignmentData.uploadedFileUrl,
                        );
                      },
                      child: Container(
                        height: 50,
                        width: deviceWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff03E627),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: const Center(
                            child: Text(
                          "Download Assignment",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
