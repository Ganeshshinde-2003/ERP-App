import 'package:erp_app/constant/models/syllabus_model.dart';
import 'package:erp_app/features/teacher/service/syllabus_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final syllabusControllerProvider = Provider(
  (ref) => SyllabusController(
    syllabusService: ref.watch(syllabusServiceProvider),
    ref: ref,
  ),
);

class SyllabusController {
  final SyllabusServices syllabusService;
  final ProviderRef ref;

  SyllabusController({required this.syllabusService, required this.ref});

  Future<SyllabusResponse?> fetchSyllabus({
    required BuildContext context,
    required String classID,
    required String subID,
    required String who,
  }) async {
    return await syllabusService.fetchSyallaBus(
      context: context,
      classID: classID,
      subID: subID,
      who: who,
    );
  }

  Future<void> updateSyllabusStatus({
    required BuildContext context,
    required String syllabusID,
    required String status,
  }) async {
    await syllabusService.updateSyallabusStatus(
      context: context,
      syllabusID: syllabusID,
      status: status,
    );
  }
}
