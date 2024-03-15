import 'package:erp_app/features/teacher/screens/upload_assignment/give_assigment.dart';
import 'package:erp_app/features/teacher/service/upload_assignment_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final uploadAssignmentControllerProvider = Provider(
  (ref) => UploadAssignmentController(
    uploadAssignmentService: ref.watch(uploadAssignmentServiceProvider),
    ref: ref,
  ),
);

class UploadAssignmentController {
  final UploadAssignmentService uploadAssignmentService;
  final ProviderRef ref;

  UploadAssignmentController({
    required this.uploadAssignmentService,
    required this.ref,
  });

  Future<void> uploadAssignment({
    required BuildContext context,
    required Assignment assignment,
  }) async {
    await uploadAssignmentService.uploadAssignment(
      context: context,
      assignment: assignment,
    );
  }
}
