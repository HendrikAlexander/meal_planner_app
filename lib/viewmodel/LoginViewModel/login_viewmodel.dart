import '../../model/user.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  String username = '';
  String password = '';
  UserRole? selectedRole;

  AppUser? loggedInUser;

  void login() {
    if (username.isNotEmpty && selectedRole != null) {
      loggedInUser = AppUser(username: username, role: selectedRole!);
      notifyListeners(); // In echter App: zur Navigation oder Statusanzeige
    }
  }

  void setUsername(String value) {
    username = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  void setRole(UserRole? role) {
    selectedRole = role;
    notifyListeners();
  }
}