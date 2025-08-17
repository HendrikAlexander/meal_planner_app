// lib/view/home/startbildschirm.dart

import 'package:flutter/material.dart';

class Startbildschirm extends StatelessWidget {
  const Startbildschirm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planner'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
            // GEÄNDERT: Die onTap-Funktion ist jetzt aktiv
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
                    const Divider(), // ERGÄNZUNG
          // ERGÄNZUNG: KACHEL FÜR DEN LOGIN
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