import 'package:erp_app/constant/models/student_time_table_model.dart';
import 'package:erp_app/features/student/service/section_time_table_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final studentSectionTimeTableControllerProvider = Provider((ref) {
  final studentSectionTimetableService =
      ref.watch(studentSectionTimeTableServiceProvider);
  return StudentSectionTimetableController(
    studentSectionTimetableService: studentSectionTimetableService,
    ref: ref,
  );
});

class StudentSectionTimetableController {
  final StudentSectionTimetableService studentSectionTimetableService;
  final ProviderRef ref;

  StudentSectionTimetableController({
    required this.studentSectionTimetableService,
    required this.ref,
  });

  Future<StudentSectionTimeTable?> getTimeTableBySection(
      BuildContext context, String who) async {
    return studentSectionTimetableService.getTimeTableBySection(
      context: context,
      who: who,
    );
  }
}
