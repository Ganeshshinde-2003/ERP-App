import 'package:erp_app/features/teacher/service/get_exams_detials_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getExamsDetailsControllerProvider = Provider((ref) {
  final getExamsService = ref.watch(getExamsServiceProvider);
  return GetExamsDetailsController(
    getExamsService: getExamsService,
    ref: ref,
  );
});

class GetExamsDetailsController {
  final GetExamsService getExamsService;
  final ProviderRef ref;
  GetExamsDetailsController({required this.getExamsService, required this.ref});

  Future<Map<String, dynamic>?> getExamsDetails(BuildContext context) async {
    return await getExamsService.getExamsDetails(context);
  }

  Future<void> storeStudentExamsMarks({
    required BuildContext context,
    required List<dynamic> data,
  }) async {
    await getExamsService.storeStudentExamsMarks(context: context, data: data);
  }
}
