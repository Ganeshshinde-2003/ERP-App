import 'package:erp_app/constant/models/get_subject_model.dart';
import 'package:erp_app/features/student/service/howework_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeWorkControllerProvider = Provider((ref) {
  final homeWorkServices = ref.watch(homeworkServiceProvider);
  return HomeWorkController(homeWorkServices: homeWorkServices, ref: ref);
});

class HomeWorkController {
  final HomeWorkServices homeWorkServices;
  final ProviderRef ref;

  HomeWorkController({required this.homeWorkServices, required this.ref});

  Future<SubjectResponse?> fetchSubjectforHoweWork(BuildContext context) async {
    return await homeWorkServices.fetchSubjectforHoweWork(context: context);
  }
}
