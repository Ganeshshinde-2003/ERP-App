// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:erp_app/constant/data/global_variable.dart';
import 'package:erp_app/constant/models/student_attendace_model.dart';
import 'package:erp_app/constant/models/user_model.dart';
import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:erp_app/constant/widgets/http_error_handler.dart';
import 'package:erp_app/constant/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// Your provider definition
final putStudentAttendanceServiceProvider = Provider(
  (ref) => PutStudentAttendance(),
);

class PutStudentAttendance {
  Future<List<StudentData>> fetchStudentAttendanceData({
    required String sectionId,
    required BuildContext context,
    required String date,
  }) async {
    SharedStoreData sharedStoreData = SharedStoreData();

    User? loadUser = await sharedStoreData.loadUserFromPreferences();
    String? authToken = loadUser?.token;

    try {
      http.Response res = await http.get(
        Uri.parse('$URI/admin/admission/getStudentAdmissionData/$sectionId'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      List<StudentData> attendanceData = [];

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final responseData = json.decode(res.body);

          if (responseData != null) {
            if (responseData['success']) {
              final data = responseData['data'];

              if (data != null && data is List) {
                attendanceData =
                    data.map((item) => StudentData.fromJson(item)).toList();
              }
            } else {
              String errorMessage = responseData['message'] ?? 'Unknown error';
              showSnackBar(context: context, content: errorMessage);
            }
          }
        },
      );

      return attendanceData;
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
      return [];
    }
  }
}
