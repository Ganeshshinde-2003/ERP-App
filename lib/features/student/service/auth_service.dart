import 'package:erp_app/features/common/bottom_navigation.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

final loginStudentService = Provider((ref) => LoginStudent());

class LoginStudent {
  Future<void> loginStudentWithUsername({
    required String userId,
    required String password,
    required BuildContext context,
  }) async {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        alignment: Alignment.lerp(
          Alignment.centerLeft,
          Alignment.centerLeft,
          0.5,
        ),
        child: const Frame(
          role: "Student",
        ),
      ),
    );
  }
}
