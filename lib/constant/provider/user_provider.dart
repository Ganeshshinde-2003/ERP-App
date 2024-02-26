// final user = Provider.of<UserProvider>(context).user;

import 'package:erp_app/constant/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: "",
    fullName: "",
    email: "",
    role: "",
    company_id: "",
    token: "",
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    saveUserToPreferences(user);
    notifyListeners();
  }

  Future<void> saveUserToPreferences(String user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user);
  }

  Future<void> loadUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUser = prefs.getString('user');
    if (savedUser != null) {
      _user = User.fromJson(savedUser);
      notifyListeners();
    }
  }
}
