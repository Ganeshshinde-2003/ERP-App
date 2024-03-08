import 'package:erp_app/constant/models/attendance_indi_model.dart';
import 'package:erp_app/features/student/service/get_attendance_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAttedanceIndiControllerProvider = Provider((ref) {
  final getIndiAttedanceService = ref.watch(getIndiAttedanceServiceProvider);
  return GetAttedanceIndiController(
    getIndiAttedanceService: getIndiAttedanceService,
    ref: ref,
  );
});

class GetAttedanceIndiController {
  final GetIndiAttedanceService getIndiAttedanceService;
  final ProviderRef ref;

  GetAttedanceIndiController({
    required this.getIndiAttedanceService,
    required this.ref,
  });

  Future<AttendanceIndiModel?> getIndiAttendance(
    int month,
    int year,
    String who,
    BuildContext context,
  ) async {
    return await getIndiAttedanceService.getIndiAttendance(
      month: month,
      year: year,
      context: context,
      who: who,
    );
  }
}
