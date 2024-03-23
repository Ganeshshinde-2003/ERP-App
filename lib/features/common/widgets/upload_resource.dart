import 'package:erp_app/features/teacher/screens/subject_wise_marks_upload.dart';
import 'package:flutter/material.dart';

class UploadResourcesPageScreen extends StatefulWidget {
  final String classID;
  final String callingWho;
  final String sectionId;
  final String isRes;
  final String isSyl;
  const UploadResourcesPageScreen({
    super.key,
    required this.classID,
    required this.callingWho,
    required this.sectionId,
    required this.isRes,
    required this.isSyl,
  });

  @override
  State<UploadResourcesPageScreen> createState() =>
      _UploadResourcesPageScreenState();
}

class _UploadResourcesPageScreenState extends State<UploadResourcesPageScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SubjectWiseMarksUpload(
            isRes: widget.isRes,
            isSyl: widget.isSyl,
            classID: widget.classID,
            callingWho: "subjects-for-resources",
            sectionId: widget.sectionId,
          ),
        ],
      ),
    );
  }
}
