// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:erp_app/constant/data/global_variable.dart';
import 'package:erp_app/constant/models/exam_result_subject_modeld.dart';
import 'package:erp_app/constant/models/fee_history_model.dart';
import 'package:erp_app/constant/models/student_login_model.dart';
import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:erp_app/constant/widgets/http_error_handler.dart';
import 'package:erp_app/constant/widgets/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final feeHistoryServiceProvider = Provider((ref) => FeesHistoryService());

class FeesHistoryService {
  Future<FeeHistory?> fetchFeeHistory({required BuildContext context}) async {
    try {
      SharedStoreData sharedStoreData = SharedStoreData();
      StudentLoginModel? loadUser =
          await sharedStoreData.loadStudentFromPreferences();
      String? authToken = loadUser?.data.token;
      FeeHistory? feeHistory;
      // String? studentId = loadUser?.data.admissionDetails.studentID.id;
      http.Response res = await http.get(
        Uri.parse(
            '$URI/admin/feeCollection/getStudentCollection/65e8851db7b36e2d7f58f91b'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final responseBody = jsonDecode(res.body);
          feeHistory = FeeHistory.fromJson(responseBody);
        },
      );
      return feeHistory;
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
      return null;
    }
  }

  Future<ExamResultSubject?> fetchExamsResultsBySubject({
    required BuildContext context,
    required String subId,
  }) async {
    SharedStoreData sharedStoreData = SharedStoreData();
    StudentLoginModel? loadUser =
        await sharedStoreData.loadStudentFromPreferences();
    String? authToken = loadUser?.data.token;
    // String? userId = loadUser?.data.admissionDetails.studentID.id;
    ExamResultSubject? examResultSubject;

    try {
      http.Response res = await http.get(
        Uri.parse(
            '$URI/admin/examResult/getStudentExamResultBySubject/65f67f971ae3b76c2103146b/65f2b840d367d433c6b685bc'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final responseBody = jsonDecode(res.body);
          examResultSubject = ExamResultSubject.fromJson(responseBody);
        },
      );

      return examResultSubject;
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
      return null;
    }
  }
}
