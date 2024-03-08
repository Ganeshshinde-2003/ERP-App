// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:erp_app/constant/data/global_variable.dart';
import 'package:erp_app/constant/models/student_login_model.dart';
import 'package:erp_app/constant/models/student_time_table_model.dart';
import 'package:erp_app/constant/models/user_model.dart';
import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:erp_app/constant/widgets/http_error_handler.dart';
import 'package:erp_app/constant/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final studentSectionTimeTableServiceProvider =
    Provider((ref) => StudentSectionTimetableService());

class StudentSectionTimetableService {
  Future<StudentSectionTimeTable?> getTimeTableBySection({
    required BuildContext context,
    required String who,
  }) async {
    SharedStoreData sharedStoreData = SharedStoreData();
    StudentSectionTimeTable? sectionTimeTable;
    http.Response res = http.Response('', 200);
    try {
      if (who == 'Student') {
        StudentLoginModel? loadUser =
            await sharedStoreData.loadStudentFromPreferences();

        String? authToken = loadUser?.data.token;
        String? sectionId = loadUser?.data.admissionDetails.sectionID.id;

        res = await http.get(
          Uri.parse('$URI/students/getscheduleBysection/$sectionId'),
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          },
        );
      }

      if (who == "Teacher") {
        User? loadUser = await sharedStoreData.loadUserFromPreferences();

        String? authToken = loadUser?.data.token;
        String? sectionId = loadUser?.data.employee.id;

        res = await http.get(
          Uri.parse('$URI/teachers/getscheduleByTeacher/$sectionId'),
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          },
        );
      }

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            final responseData = json.decode(res.body);
            sectionTimeTable = StudentSectionTimeTable.fromJson(responseData);
          });
      return sectionTimeTable;
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
      return null;
    }
  }
}
