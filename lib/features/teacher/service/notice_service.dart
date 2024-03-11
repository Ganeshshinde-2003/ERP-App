// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:erp_app/constant/data/global_variable.dart';
import 'package:erp_app/constant/models/notice_model.dart';
import 'package:erp_app/constant/models/student_login_model.dart';
import 'package:erp_app/constant/models/user_model.dart';
import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:erp_app/constant/widgets/http_error_handler.dart';
import 'package:erp_app/constant/widgets/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final noticeServiceProvider = Provider((ref) => NoticeSerivce());

class NoticeSerivce {
  Future<NoticesModel?> fetchNotice({
    required BuildContext context,
    required String who,
  }) async {
    try {
      SharedStoreData sharedStoreData = SharedStoreData();
      String? authToken;
      String uri;
      NoticesModel? noticesModel;
      if (who == "Student") {
        StudentLoginModel? loadStdent =
            await sharedStoreData.loadStudentFromPreferences();
        authToken = loadStdent?.data.token;
        uri = "$URI/students/notices";
      } else {
        User? loadTeacher = await sharedStoreData.loadUserFromPreferences();
        authToken = loadTeacher?.data.token;
        uri = "$URI/teachers/notices";
      }
      http.Response res = await http.get(
        Uri.parse(uri),
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
          noticesModel = NoticesModel.fromJson(responseBody);
        },
      );

      return noticesModel;
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
      null;
    }
    return null;
  }
}
