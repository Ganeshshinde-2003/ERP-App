// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:erp_app/constant/data/global_variable.dart';
import 'package:erp_app/constant/models/events_model.dart';
import 'package:erp_app/constant/models/student_login_model.dart';
import 'package:erp_app/constant/models/user_model.dart';
import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:erp_app/constant/widgets/http_error_handler.dart';
import 'package:erp_app/constant/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final eventServiceProvider = Provider((ref) => EventsService());

class EventsService {
  Future<EventsModel?> fetchEvents({
    required BuildContext context,
    required String who,
  }) async {
    try {
      SharedStoreData sharedStoreData = SharedStoreData();
      String? authToken;
      EventsModel? eventsModel;

      if (who == "Student") {
        StudentLoginModel? loadStdent =
            await sharedStoreData.loadStudentFromPreferences();
        authToken = loadStdent?.data.token;
      } else {
        User? loadTeacher = await sharedStoreData.loadUserFromPreferences();
        authToken = loadTeacher?.data.token;
      }

      http.Response res = await http.get(
        Uri.parse("$URI/common/events/active"),
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
          eventsModel = EventsModel.fromJson(responseBody);
        },
      );

      return eventsModel;
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
      return null;
    }
  }
}
