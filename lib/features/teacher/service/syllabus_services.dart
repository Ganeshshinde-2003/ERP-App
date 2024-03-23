// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:erp_app/constant/data/global_variable.dart';
import 'package:erp_app/constant/models/student_login_model.dart';
import 'package:erp_app/constant/models/syllabus_model.dart';
import 'package:erp_app/constant/models/user_model.dart';
import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:erp_app/constant/widgets/http_error_handler.dart';
import 'package:erp_app/constant/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final syllabusServiceProvider = Provider((ref) => SyllabusServices());

class SyllabusServices {
  Future<SyllabusResponse?> fetchSyallaBus({
    required BuildContext context,
    required String classID,
    required String subID,
    required String who,
  }) async {
    SharedStoreData sharedStoreData = SharedStoreData();

    String? authToken;
    SyllabusResponse? syllabusResponse;

    if (who == "Student") {
      StudentLoginModel? studentData =
          await sharedStoreData.loadStudentFromPreferences();
      authToken = studentData?.data.token;
    } else {
      User? loadUser = await sharedStoreData.loadUserFromPreferences();
      authToken = loadUser?.data.token;
    }

    try {
      http.Response res = await http.get(
        Uri.parse('$URI/common/syllabus/$classID/$subID'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final resBody = json.decode(res.body);
          syllabusResponse = SyllabusResponse.fromJson(resBody);
        },
      );

      return syllabusResponse;
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
      return null;
    }
  }

  Future<void> updateSyallabusStatus({
    required BuildContext context,
    required String syllabusID,
    required String status,
  }) async {
    SharedStoreData sharedStoreData = SharedStoreData();
    User? loadUser = await sharedStoreData.loadUserFromPreferences();
    String? authToken = loadUser?.data.token;

    try {
      http.Response res = await http.put(
        Uri.parse('$URI/admin/syllabus/$syllabusID'),
        body: jsonEncode({"status": status}),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context: context, content: "Syllabus Updated");
        },
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
