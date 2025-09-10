// lib/view/Startseite/startbildschirm.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/user.dart';
import '../../viewmodel/LoginViewModel/login_viewmodel.dart';

class Startbildschirm extends StatelessWidget {
  const Startbildschirm({super.key});

  @override
  Widget build(BuildContext context) {
    // Wir holen uns die Instanz des LoginViewModels, die von Provider verwaltet wird.
    final loginVM = Provider.of<LoginViewModel>(context);

    // Wir bauen den Text zusammen, der angezeigt werden soll.
    String anzeigeText = '';
    if (loginVM.loggedInUser != null) {
      final user = loginVM.loggedInUser!;
      // Wir wandeln die Rolle in einen schön lesbaren Text um.
      final rolle = user.role == UserRole.admin ? 'Admin' : 'User';
      anzeigeText = 'Angemeldet als: ${user.username} ($rolle)';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planner'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        automaticallyImplyLeading: false,
        // NEU: Die "actions"-Eigenschaft fügt Widgets auf der rechten Seite der AppBar hinzu.
        actions: [
          // Wir zeigen den Text nur an, wenn ein Benutzer eingeloggt ist.
          if (loginVM.loggedInUser != null)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: Text(anzeigeText),
              ),
            ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.restaurant_menu),
            title: const Text('Speisekarte verwalten'),
            subtitle:
                const Text('Alle verfügbaren Essen anlegen, bearbeiten und löschen'),
            onTap: () {
              Navigator.pushNamed(context, '/speisekarte');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text('Wochenpläne'),
            subtitle:
                const Text('Essenspläne für die nächsten Wochen anzeigen'),
            onTap: () {
              Navigator.pushNamed(context, '/essensplan');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.reviews),
            title: const Text('Bewertungen'),
            subtitle: const Text('Alle abgegebenen Bewertungen einsehen'),
            onTap: () {
              Navigator.pushNamed(context, '/bewertungen');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Login'),
            subtitle: const Text('Anmelden, als Admin oder Nutzer'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}