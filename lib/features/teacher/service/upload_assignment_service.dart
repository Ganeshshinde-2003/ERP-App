// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:erp_app/constant/data/global_variable.dart';
import 'package:erp_app/constant/models/student_login_model.dart';
import 'package:erp_app/constant/models/user_model.dart';
import 'package:erp_app/constant/models/view_assignment_model.dart';
import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:erp_app/constant/widgets/http_error_handler.dart';
import 'package:erp_app/constant/widgets/snack_bar.dart';
import 'package:erp_app/features/teacher/screens/upload_assignment/give_assigment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final uploadAssignmentServiceProvider =
    Provider((ref) => UploadAssignmentService());

class UploadAssignmentService {
  Future<void> uploadAssignment({
    required BuildContext context,
    required Assignment assignment,
  }) async {
    SharedStoreData sharedStoreData = SharedStoreData();

    User? loadUser = await sharedStoreData.loadUserFromPreferences();
    String? authToken = loadUser?.data.token;
    try {
      if (assignment.uploadedFile != null) {
        var fileStream = assignment.uploadedFile!.openRead();
        var httpClient = http.Client();
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('$URI/assignments/create/'),
        );

        request.headers['Authorization'] = 'Bearer $authToken';

        request.fields['title'] = assignment.title;
        request.fields['subjectId'] = assignment.subjectId;
        request.fields['description'] = assignment.description;
        request.fields['dueDate'] = assignment.dueDate?.toIso8601String() ?? '';
        request.fields['teacherId'] = assignment.teacherId;
        request.fields['sectionId'] = assignment.sectionId;

        request.files.add(
          http.MultipartFile(
            'uploadedFile',
            fileStream,
            await assignment.uploadedFile!.length(),
            filename: assignment.uploadedFile!.path.split('/').last,
          ),
        );

        var response = await httpClient.send(request);
        var httpResponse = await http.Response.fromStream(response);
        httpErrorHandle(
          response: httpResponse,
          context: context,
          onSuccess: () async {
            final responseData = json.decode(httpResponse.body);
            if (responseData['success']) {
              showSnackBar(context: context, content: responseData['message']);
              Navigator.pop(context);
            }
          },
        );
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  Future<AssignmentDataModel?> getAssingmentBySection({
    required String sectionId,
    required String subId,
    required String who,
    required BuildContext context,
  }) async {
    SharedStoreData sharedStoreData = SharedStoreData();

    String? authToken;
    AssignmentDataModel? assignmentDataModel;

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
        Uri.parse('$URI/assignments/$sectionId/$subId'),
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
          assignmentDataModel = AssignmentDataModel.fromJson(resBody);
        },
      );
      return assignmentDataModel;
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
      return null;
    }
  }
}
