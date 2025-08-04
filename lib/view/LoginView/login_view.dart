import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/user.dart';
import '../../viewmodel/LoginViewModel/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SingleChildScrollView( // <-- NEU: Scrollbarer Bereich
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Verhindert „unendliche“ Höhe
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Benutzername"),
                onChanged: vm.setUsername,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(labelText: "Passwort"),
                obscureText: true,
                onChanged: vm.setPassword,
              ),
              const SizedBox(height: 10),
              DropdownButton<UserRole>(
                value: vm.selectedRole,
                hint: const Text("Rolle auswählen"),
                items: UserRole.values.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role == UserRole.admin ? "Admin" : "User"),
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
                child: const Text("Einloggen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}