import 'package:erp_app/features/teacher/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginTeahcerControllerProvider = Provider((ref) {
  final loginTeacher = ref.watch(loginTeacherService);
  return LoginTeacherController(loginTeacher: loginTeacher, ref: ref);
});

class LoginTeacherController {
  final LoginTeacher loginTeacher;
  final ProviderRef ref;

  LoginTeacherController({
    required this.loginTeacher,
    required this.ref,
  });

  Future<void> loginTeacherWithUserNamePassword(
    BuildContext context,
    String userId,
    String password,
    String who,
  ) async {
    await loginTeacher.loginTeacherWithUsername(
        userId: userId, password: password, context: context, who: who);
  }

  void logoutUser(BuildContext context) {
    loginTeacher.logoutUser(context: context);
  }
}
