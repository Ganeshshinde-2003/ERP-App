import 'package:erp_app/constant/models/master_model.dart';
import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final masterDataUtilServiceProvider =
    Provider((ref) => MasterDataUtilService());

class MasterDataUtilService {
  Future<List<Class>?> loadClassList() async {
    try {
      SharedStoreData sharedStoreData = SharedStoreData();

      MasterDataCache? masterData =
          await sharedStoreData.loadMasterDataCacheFromPreferences();
      if (masterData != null) {
        return masterData.data.classes;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Section>?> loadSectionList(String classId) async {
    try {
      SharedStoreData sharedStoreData = SharedStoreData();

      MasterDataCache? masterData =
          await sharedStoreData.loadMasterDataCacheFromPreferences();
      if (masterData != null) {
        List<Section>? filteredSections = masterData.data.sections
            .where((section) => section.classId == classId)
            .toList();

        return filteredSections;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
