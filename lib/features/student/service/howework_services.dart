// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:erp_app/constant/data/global_variable.dart';
import 'package:erp_app/constant/models/get_subject_model.dart';
import 'package:erp_app/constant/models/student_login_model.dart';
import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:erp_app/constant/widgets/http_error_handler.dart';
import 'package:erp_app/constant/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final homeworkServiceProvider = Provider((ref) => HomeWorkServices());

class HomeWorkServices {
  Future<SubjectResponse?> fetchSubjectforHoweWork(
      {required BuildContext context}) async {
    try {
      SharedStoreData sharedStoreData = SharedStoreData();
      StudentLoginModel? loadUser =
          await sharedStoreData.loadStudentFromPreferences();

      String? authToken = loadUser?.data.token;
      String? classId = loadUser?.data.admissionDetails.classID.id;
      SubjectResponse? subjectResponse;

      http.Response res = await http.get(
        Uri.parse('$URI/students/subjects/$classId'),
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
          subjectResponse = SubjectResponse.fromJson(responseBody);
        },
      );

      return subjectResponse;
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
      return null;
    }
  }
}
