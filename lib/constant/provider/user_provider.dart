import 'dart:convert';

import 'package:erp_app/constant/models/master_model.dart';
import 'package:erp_app/constant/models/student_login_model.dart';
import 'package:erp_app/constant/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedStoreData {
  Future<StudentLoginModel?> loadStudentFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('user');
    if (jsonString != null) {
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return StudentLoginModel.fromJson(jsonData);
    } else {
      return null;
    }
  }

  Future<void> saveStudentToPreferences(StudentLoginModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = json.encode(user.toJson());
    prefs.setString('user', userJson);
    storeUserRole(user.data.user.role);
  }

  Future<void> storeUserRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("UserRole", role);
  }

  Future<String?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("UserRole");
  }

  Future<User?> loadUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('user');
    if (jsonString != null) {
      return User.fromJson(jsonString);
    } else {
      return null;
    }
  }

  Future<void> saveUserToPreferences(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user.toJson());
    storeUserRole(user.role);
  }

  Future<MasterDataCache?> loadMasterDataCacheFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('masterDataCache');
    if (jsonString != null) {
      return MasterDataCache.fromJson(json.decode(jsonString));
    } else {
      return null;
    }
  }

  Future<void> saveMasterDataCache(MasterDataCache masterDataCache) async {
    final prefs = await SharedPreferences.getInstance();
    final masterDataCacheJson = json.encode(masterDataCache.toJson());
    prefs.setString('masterDataCache', masterDataCacheJson);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('UserRole');
  }

  Future<bool?> loadAttendanceStatus(String date) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('attendanceStatus_$date') ?? false;
  }

  Future<void> saveAttendanceStatus(String date, bool status) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('attendanceStatus_$date', status);
  }
}
