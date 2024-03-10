// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:erp_app/constant/data/global_variable.dart';
import 'package:erp_app/constant/models/student_attendace_model.dart';
import 'package:erp_app/constant/models/user_model.dart';
import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:erp_app/constant/widgets/http_error_handler.dart';
import 'package:erp_app/constant/widgets/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

// Your provider definition
final putStudentAttendanceServiceProvider = Provider(
  (ref) => PutStudentAttendance(),
);

class PutStudentAttendance {
  Future<List<dynamic>> fetchStudentAttendanceData({
    required String sectionId,
    required BuildContext context,
    required String date,
  }) async {
    SharedStoreData sharedStoreData = SharedStoreData();

    User? loadUser = await sharedStoreData.loadUserFromPreferences();
    String? authToken = loadUser?.data.token;

    try {
      http.Response res = await http.get(
        Uri.parse('$URI/students/getStudentAdmissionData/$sectionId'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      List<StudentData> attendanceData = [];
      List<bool> attendanceStatus = [];

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

              bool? loadAttendanceStatus =
                  await sharedStoreData.loadAttendanceStatus(date);

              if (loadAttendanceStatus!) {
                http.Response attendanceRes = await http.get(
                  Uri.parse('$URI/students/attendance/$sectionId/$date'),
                  headers: {
                    'Authorization': 'Bearer $authToken',
                    'Content-Type': 'application/json',
                  },
                );

                httpErrorHandle(
                  response: attendanceRes,
                  context: context,
                  onSuccess: () async {
                    final attendanceResponseData =
                        json.decode(attendanceRes.body);
                    Map<String, dynamic>? data = attendanceResponseData['data'];

                    if (data != null) {
                      List<String> absentList =
                          List<String>.from(data['absent']);
                      List<String> presentList =
                          List<String>.from(data['present']);

                      for (String _ in absentList) {
                        attendanceStatus.add(false);
                      }
                      for (String _ in presentList) {
                        attendanceStatus.add(true);
                      }
                      await sharedStoreData
                          .saveAttendanceStatusToSharedPreferences(
                              attendanceStatus);
                    } else {
                      showSnackBar(
                        context: context,
                        content: "No data available",
                      );
                    }
                  },
                );
              }
            } else {
              String errorMessage = responseData['message'] ?? 'Unknown error';
              showSnackBar(context: context, content: errorMessage);
            }
          }
        },
      );
      return [attendanceData, attendanceStatus];
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
      return [[], []];
    }
  }

  Future<void> saveAttendanceData({
    required Map<String, dynamic> attendanceData,
    required BuildContext context,
  }) async {
    SharedStoreData sharedStoreData = SharedStoreData();

    User? loadUser = await sharedStoreData.loadUserFromPreferences();
    String? authToken = loadUser?.data.token;

    http.Response res = await http.post(
      Uri.parse("$URI/students/attendance/save"),
      body: jsonEncode(attendanceData),
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
        String currentDate = DateTime.now().toLocal().toString().split(' ')[0];
        await sharedStoreData.saveAttendanceStatus(currentDate, true);
        Fluttertoast.showToast(msg: responseData['message']);
        Navigator.pop(context);
      },
    );
  }
}
