// final user = Provider.of<UserProvider>(context).user;

import 'package:erp_app/constant/models/user_model.dart';
import 'package:flutter/material.dart';

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
    notifyListeners();
  }
}
