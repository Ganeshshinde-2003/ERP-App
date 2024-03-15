// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:erp_app/constant/models/user_model.dart';
import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:erp_app/constant/widgets/snack_bar.dart';
import 'package:erp_app/features/teacher/controller/upload_assigment_conroller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class Assignment {
  final String title;
  final String subjectId;
  final String description;
  final DateTime? dueDate;
  final String teacherId;
  final String sectionId;
  final File? uploadedFile;

  Assignment({
    required this.title,
    required this.subjectId,
    required this.description,
    required this.dueDate,
    required this.teacherId,
    required this.sectionId,
    this.uploadedFile,
  });
}

class GiveAssignmentScreen extends ConsumerStatefulWidget {
  final String sectionId;
  final String classId;
  final String subId;
  final String subName;
  const GiveAssignmentScreen({
    Key? key,
    required this.classId,
    required this.sectionId,
    required this.subId,
    required this.subName,
  }) : super(key: key);

  @override
  ConsumerState<GiveAssignmentScreen> createState() =>
      _GiveAssignmentScreenState();
}

class _GiveAssignmentScreenState extends ConsumerState<GiveAssignmentScreen> {
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  SharedStoreData sharedStoreData = SharedStoreData();
  DateTime? _selectedDate;
  Assignment? _assignment;
  File? _pickedFile;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _deadlineController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      _pickedFile = File(file.path!);
    } else {
      showSnackBar(context: context, content: "User canceled file picking");
    }

    setState(() {});
  }

  void _submitAssignment() async {
    User? user = await sharedStoreData.loadUserFromPreferences();
    var teacherId = user!.data.employee.id;

    _assignment = Assignment(
      title: _titleController.text,
      subjectId: widget.subId,
      description: _descriptionController.text,
      dueDate: _selectedDate,
      teacherId: teacherId,
      sectionId: widget.sectionId,
      uploadedFile: _pickedFile,
    );

    ref.read(uploadAssignmentControllerProvider).uploadAssignment(
          context: context,
          assignment: _assignment!,
        );
  }

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
          SingleChildScrollView(
            child: SizedBox(
              height: deviceHeight,
              width: deviceWidth,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.subName,
                            style: AppTextStyles.bodyText.copyWith(
                              fontSize: 20,
                              color: const Color(0xFF868686),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 8,
                                child: GestureDetector(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
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
                                    child: TextFormField(
                                      controller: _deadlineController,
                                      decoration: const InputDecoration(
                                        hintText: 'Deadline',
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.calendar_month),
                                      ),
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    _pickFile();
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
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
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.link, color: Colors.black),
                                        SizedBox(width: 5),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                            child: TextField(
                              controller: _titleController,
                              decoration: const InputDecoration(
                                hintText: 'Title',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                            child: TextField(
                              controller: _descriptionController,
                              maxLines: 8,
                              decoration: const InputDecoration(
                                hintText: 'Description',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap:
                                _submitAssignment, // Call submit function on tap
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xFF03E627),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "Upload",
                                  style: AppTextStyles.heading1.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
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

  @override
  void dispose() {
    _deadlineController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
