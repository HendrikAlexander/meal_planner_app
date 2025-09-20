import '../../model/user.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  Locale _currentLocale = const Locale('de');
  Locale get currentLocale => _currentLocale;
  void setLocale(Locale locale) {
    if (_currentLocale == locale) return;
    _currentLocale = locale;
    notifyListeners();
  }
  String username = '';
  String password = '';
  UserRole selectedRole = UserRole.user;

  AppUser? loggedInUser; 
 
  

  UserRole? get currentRole => loggedInUser?.role;

  void login() {
    if (username.isNotEmpty && selectedRole != null) {
      loggedInUser = AppUser(username: username, role: selectedRole!);
      notifyListeners();
    }
  }


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
    if (role != null) {
      selectedRole = role;
      notifyListeners();
    }
  }
}
