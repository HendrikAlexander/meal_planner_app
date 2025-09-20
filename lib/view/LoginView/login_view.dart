
import 'package:flutter/material.dart';
import 'package:meal_planner_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../model/user.dart';
import '../../viewmodel/LoginViewModel/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginViewModel>(context, listen: false);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.login),automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch, 
            children: [
              TextField(
                decoration: InputDecoration(labelText: l10n.username),
                onChanged: vm.setUsername,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(labelText: l10n.password),
                obscureText: true,
                onChanged: vm.setPassword,
              ),
              const SizedBox(height: 10),
              DropdownButton<UserRole>(
                value: context.watch<LoginViewModel>().selectedRole,
                isExpanded: true, 
                hint:  Text(l10n.selectRole),
                items: UserRole.values.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role == UserRole.admin ? l10n.adminRole : l10n.userRole),
                  );
                }).toList(),
                onChanged: vm.setRole,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  vm.login();
                  if (vm.loggedInUser != null) {
                    Navigator.pushReplacementNamed(context, '/');
                  }
                },
                child: Text(l10n.loginButton),
              ),
               SizedBox(height: 10),
              
              TextButton(
                onPressed: () {
                  
                  vm.loginAsGuest();
                  
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text(l10n.continueAsGuest),
              ),
               
              Text("${AppLocalizations.of(context)!.changeLanguage}:"),
              const SizedBox(height: 10),
              Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    TextButton(
      onPressed: () {
        vm.setLocale(const Locale('de'));
      },
      child: const Text('Deutsch 🇩🇪'),
    ),
    const SizedBox(width: 20),
    TextButton(
      onPressed: () {
        vm.setLocale(const Locale('en'));
      },
      child: const Text('English 🇬🇧'),
   ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}