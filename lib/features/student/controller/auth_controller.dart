import 'package:erp_app/features/student/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginStudentControllerProvider = Provider((ref) {
  final loginStudent = ref.watch(loginStudentService);
  return LoginStudentController(loginStudent: loginStudent, ref: ref);
});

class LoginStudentController {
  final LoginStudent loginStudent;
  final ProviderRef ref;

  LoginStudentController({
    required this.loginStudent,
    required this.ref,
  });

  void loginStudentWithUserNamePassword(
      BuildContext context, String userId, String password) {
    loginStudent.loginStudentWithUsername(
      userId: userId,
      password: password,
      context: context,
    );
  }
}
