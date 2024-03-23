import 'package:erp_app/constant/text_style.dart';
import 'package:flutter/material.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/constant/models/syllabus_model.dart';

class ChapterDetailsPageScreen extends StatefulWidget {
  final Syllabus syllabus;

  const ChapterDetailsPageScreen({
    Key? key,
    required this.syllabus,
  }) : super(key: key);

  @override
  State<ChapterDetailsPageScreen> createState() =>
      _ChapterDetailsPageScreenState();
}

class _ChapterDetailsPageScreenState extends State<ChapterDetailsPageScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(context, widget.syllabus.title),
      body: Stack(
        children: [
          BottomImageBar(deviceWidth: deviceWidth, color: "Green"),
          Container(
            margin: const EdgeInsets.only(
              bottom: 130,
              top: 30,
              left: 20,
              right: 20,
            ),
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 10,
              left: 20,
              right: 20,
            ),
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
            child: ListView(
              children: [
                Text(
                  'Chapter Number: ${widget.syllabus.chapterNo}',
                  style: AppTextStyles.heading1,
                ),
                const SizedBox(height: 10),
                Text(
                  'Title: ${widget.syllabus.title}',
                  style: AppTextStyles.heading2,
                ),
                const SizedBox(height: 10),
                Text(
                  'Description: ${widget.syllabus.description}',
                  style: AppTextStyles.heading2,
                ),
                const SizedBox(height: 10),
                Text(
                  'Additional Information: ${widget.syllabus.additionalInformation}',
                  style: AppTextStyles.heading2,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.syllabus.status == "in_progress"
                      ? "Status: In Progress"
                      : widget.syllabus.status == "completed"
                          ? "Status: Completed"
                          : "Status: Pending",
                  style: AppTextStyles.heading2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
