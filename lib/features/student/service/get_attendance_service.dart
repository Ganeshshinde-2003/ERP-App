// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:erp_app/constant/data/global_variable.dart';
import 'package:erp_app/constant/models/attendance_indi_model.dart';
import 'package:erp_app/constant/models/student_login_model.dart';
import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:erp_app/constant/widgets/http_error_handler.dart';
import 'package:erp_app/constant/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final getIndiAttedanceServiceProvider =
    Provider((ref) => GetIndiAttedanceService());

class GetIndiAttedanceService {
  // ignore: constant_identifier_names
  static const String API_ENDPOINT = '$URI/students/monthly-attendance-report';

  Future<AttendanceIndiModel?> getIndiAttendance({
    required int month,
    required int year,
    required BuildContext context,
    required String who,
  }) async {
    SharedStoreData sharedStoreData = SharedStoreData();
    AttendanceIndiModel? attendanceIndiModel;
    StudentLoginModel? studentLoginModel =
        await sharedStoreData.loadStudentFromPreferences();
    String? authToken = studentLoginModel?.data.token;

    try {
      http.Response res = await http.post(
        Uri.parse(API_ENDPOINT),
        body: jsonEncode({
          'studentId': "65e0d3f2026813d9450ec86a",
          'month': month,
          'year': year,
        }),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final responseData = json.decode(res.body);
          attendanceIndiModel = AttendanceIndiModel.fromJson(responseData);
        },
      );

      return attendanceIndiModel;
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
      return null;
    }
  }
}
