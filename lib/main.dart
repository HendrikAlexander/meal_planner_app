// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Bestehende Importe
import 'view/SpeisekarteView/essen_dialog.dart';
import 'view/Startseite/startbildschirm.dart';
import 'view/EssensplanView/essensplan_dialog.dart';
import 'view/EssensbewertungView/bewertung_dialog.dart';
import 'viewmodel/EssensbewertungViewModel/essensbewertung_viewmodel.dart';

// NEU: Login-View + ViewModel importieren
import 'view/LoginView/login_view.dart';
import 'viewmodel/LoginViewModel/login_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EssensbewertungViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()), // NEU
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Planner App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialRoute: '/login', // <-- NEU: Login zuerst anzeigen
      routes: {
        '/': (context) => const Startbildschirm(),
        '/login': (context) => const LoginView(),
        '/speisekarte': (context) => const EssenDialog(),
        '/essensplan': (context) => const EssensplanDialog(),
        '/bewertungen': (context) => const BewertungDialog(),
      },
    );
  }
}