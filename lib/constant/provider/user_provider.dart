import 'package:erp_app/constant/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedStoreData {
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
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }
}
