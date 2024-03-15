// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:erp_app/constant/data/global_variable.dart';
import 'package:erp_app/constant/models/user_model.dart';
import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:erp_app/constant/widgets/http_error_handler.dart';
import 'package:erp_app/constant/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final getExamsServiceProvider = Provider((ref) => GetExamsService());

class GetExamsService {
  Future<Map<String, dynamic>?> getExamsDetails(BuildContext context) async {
    SharedStoreData sharedStoreData = SharedStoreData();

    User? loadUser = await sharedStoreData.loadUserFromPreferences();
    String? authToken = loadUser?.data.token;
    var responseBody;

    try {
      http.Response res = await http.get(
        Uri.parse('$URI/admin/examResult/getAllExamResults'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      if (res.body.isNotEmpty) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            responseBody = json.decode(res.body);
          },
        );
      } else {
        showSnackBar(context: context, content: "No Data Found");
      }

      return responseBody;
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
      return null;
    }
  }
}
