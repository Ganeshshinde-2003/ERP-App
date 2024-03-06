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
        Uri.parse('$URI/students/getStudentAdmissionData/$sectionId'),
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

              // Check if loadAttendanceStatus is true
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
                  onSuccess: () {
                    final attendanceResponseData =
                        json.decode(attendanceRes.body);

                    if (attendanceResponseData['success']) {
                      final absentDataList =
                          attendanceResponseData['data']['absent'];
                      final presentDataList =
                          attendanceResponseData['data']['present'];

                      for (var studentData in attendanceData) {
                        if (absentDataList.contains(studentData.id)) {
                          studentData.attendanceStatus = false;
                        } else if (presentDataList.contains(studentData.id)) {
                          studentData.attendanceStatus = true;
                        }
                      }
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

      return attendanceData;
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
      return [];
    }
  }

  Future<void> saveAttendanceData({
    required Map<String, dynamic> attendanceData,
    required BuildContext context,
  }) async {
    SharedStoreData sharedStoreData = SharedStoreData();

    User? loadUser = await sharedStoreData.loadUserFromPreferences();
    String? authToken = loadUser?.token;

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
