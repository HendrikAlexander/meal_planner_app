import '../../model/user.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  String username = '';
  String password = '';
  UserRole? selectedRole;

  AppUser? loggedInUser;

  get currentRole => selectedRole;

  void login() {
    if (username.isNotEmpty && selectedRole != null) {
      loggedInUser = AppUser(username: username, role: selectedRole!);
      notifyListeners();
    }
  }

  // NEUE FUNKTION: Meldet den Benutzer als Gast an.
  void loginAsGuest() {
    loggedInUser = AppUser(username: 'Gast', role: UserRole.user);
    selectedRole = UserRole.user;
    notifyListeners();
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