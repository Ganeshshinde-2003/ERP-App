import 'package:erp_app/features/teacher/service/student_fetching_for_attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final putStudentAttendanceControllerProvider = Provider((ref) {
  final putStudentAttendance = ref.watch(putStudentAttendanceServiceProvider);
  return PutStudentAttendanceController(
    putStudentAttendance: putStudentAttendance,
    ref: ref,
  );
});

class PutStudentAttendanceController {
  final PutStudentAttendance putStudentAttendance;
  final ProviderRef ref;

  PutStudentAttendanceController({
    required this.putStudentAttendance,
    required this.ref,
  });

  Future<List<dynamic>> fetchStudentAttendanceData(
    BuildContext context,
    String sectionId,
    String date,
  ) async {
    return await putStudentAttendance.fetchStudentAttendanceData(
      sectionId: sectionId,
      context: context,
      date: date,
    );
  }

  Future<void> saveAttendanceData(
    Map<String, dynamic> attendanceData,
    BuildContext context,
  ) async {
    putStudentAttendance.saveAttendanceData(
      attendanceData: attendanceData,
      context: context,
    );
  }
}
