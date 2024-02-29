// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:erp_app/constant/models/master_model.dart';
import 'package:erp_app/features/teacher/service/attendance_service.dart';

final masterDataUtilControllerProvider = Provider((ref) {
  final masterDataUtilService = ref.read(masterDataUtilServiceProvider);
  return MasterDataUtilController(
    masterDataUtilService: masterDataUtilService,
    ref: ref,
  );
});

class MasterDataUtilController {
  final MasterDataUtilService masterDataUtilService;
  final ProviderRef ref;
  MasterDataUtilController({
    required this.masterDataUtilService,
    required this.ref,
  });

  Future<List<Class>?> getMasterClassData() async {
    return masterDataUtilService.loadClassList();
  }

  Future<List<Section>?> getMasterSectionData(String classID) async {
    return masterDataUtilService.loadSectionList(classID);
  }
}
