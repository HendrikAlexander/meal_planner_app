// lib/view/Startseite/startbildschirm.dart

import 'package:flutter/material.dart';
import 'package:meal_planner_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../model/user.dart';
import '../../viewmodel/LoginViewModel/login_viewmodel.dart';

class Startbildschirm extends StatelessWidget {
  const Startbildschirm({super.key});

  @override
  Widget build(BuildContext context) {
    // Wir holen uns die Instanz des LoginViewModels, die von Provider verwaltet wird.
    final loginVM = Provider.of<LoginViewModel>(context);
    final l10n = AppLocalizations.of(context)!;

    // Wir bauen den Text zusammen, der angezeigt werden soll.
    String anzeigeText = '';
    if (loginVM.loggedInUser != null) {
      final user = loginVM.loggedInUser!;
      // Wir wandeln die Rolle in einen schön lesbaren Text um.
      final rolle = user.role == UserRole.admin ? l10n.adminRole : l10n.userRole;
      anzeigeText = l10n.loggedInAsInfo(user.username, rolle);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
            title: Text(l10n.manageMenuTitle),
            subtitle:
                Text(l10n.manageMenuSubtitle),
            onTap: () {
              Navigator.pushNamed(context, '/speisekarte');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: Text(l10n.weeklyPlansTitle),
            subtitle:
                Text(l10n.weeklyPlansSubtitle),
            onTap: () {
              Navigator.pushNamed(context, '/essensplan');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.reviews),
            title: Text(l10n.reviewsTitle),
            subtitle: Text(l10n.reviewsSubtitle),
            onTap: () {
              Navigator.pushNamed(context, '/bewertungen');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.login),
            title: Text(l10n.login),
            subtitle: Text(l10n.loginSubtitle),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}