import 'package:erp_app/constant/models/exam_result_subject_modeld.dart';
import 'package:erp_app/constant/models/fee_history_model.dart';
import 'package:erp_app/features/student/service/fee_history_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final feeHistoryControllerProvider = Provider((ref) {
  final feesHistoryService = ref.watch(feeHistoryServiceProvider);
  return FeeHistoryController(feesHistoryService: feesHistoryService, ref: ref);
});

class FeeHistoryController {
  final FeesHistoryService feesHistoryService;
  final ProviderRef ref;

  FeeHistoryController({required this.feesHistoryService, required this.ref});

  Future<FeeHistory?> fetchFeeHistory(BuildContext context) async {
    return await feesHistoryService.fetchFeeHistory(context: context);
  }

  Future<ExamResultSubject?> fetchExamsResulsBySubject(
      BuildContext context, String subId) async {
    return await feesHistoryService.fetchExamsResultsBySubject(
      context: context,
      subId: subId,
    );
  }
}
