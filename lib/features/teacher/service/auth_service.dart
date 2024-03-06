// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:erp_app/constant/data/global_variable.dart';
import 'package:erp_app/constant/models/master_model.dart';
import 'package:erp_app/constant/models/user_model.dart';
import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:erp_app/constant/widgets/http_error_handler.dart';
import 'package:erp_app/constant/widgets/snack_bar.dart';
import 'package:erp_app/features/common/bottom_navigation.dart';
import 'package:erp_app/features/common/landing_page.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

final loginTeacherService = Provider((ref) => LoginTeacher());

class LoginTeacher {
  Future<void> loginTeacherWithUsername({
    required String userId,
    required String password,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$URI/users/login'),
        body: jsonEncode({
          'email': userId,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final responseBody = jsonDecode(res.body);
          SharedStoreData sharedStoreData = SharedStoreData();

          User user = User(
            id: responseBody['data']['user']['id'],
            fullName: responseBody['data']['user']['fullName'],
            email: responseBody['data']['user']['email'],
            role: responseBody['data']['user']['role'],
            company_id:
                responseBody['data']['user']['company_id'] ?? "ENG21CS0135",
            token: responseBody['data']['token'],
          );

          await sharedStoreData.saveUserToPreferences(user);
          User? user2 = await sharedStoreData.loadUserFromPreferences();

          showSnackBar(
            context: context,
            content: jsonDecode(res.body)['message'],
          );
          if (user2?.role == "admin") {
            await getMasterDataToChache(context: context);
          }
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              alignment: Alignment.lerp(
                Alignment.centerLeft,
                Alignment.centerLeft,
                0.5,
              ),
              child: user2?.role == "admin"
                  ? const Frame(role: "Teacher")
                  : const Frame(role: "Student"),
            ),
          );
        },
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void logoutUser({required BuildContext context}) async {
    SharedStoreData sharedStoreData = SharedStoreData();
    await sharedStoreData.logout();
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        alignment: Alignment.lerp(
          Alignment.centerLeft,
          Alignment.centerLeft,
          0.5,
        ),
        child: const LandingPage(),
      ),
    );
  }

  Future<void> getMasterDataToChache({required BuildContext context}) async {
    SharedStoreData sharedStoreData = SharedStoreData();

    User? loadUser = await sharedStoreData.loadUserFromPreferences();
    String? authToken = loadUser?.token;

    try {
      final response = await http.get(
        Uri.parse('$URI/commonmaster/getCommonMasterData'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async {
          final responseData = json.decode(response.body);
          MasterDataCache masterDataCache =
              MasterDataCache.fromJson(responseData);
          await sharedStoreData.saveMasterDataCache(masterDataCache);
        },
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
