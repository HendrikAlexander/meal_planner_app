// lib/main.dart

import 'package:flutter/material.dart';
import 'view/SpeisekarteView/essen_dialog.dart';
// GEÄNDERT: Der Import-Pfad zeigt jetzt auf die neue Datei
import 'view/Startseite/startbildschirm.dart';
import 'view/EssensplanView/essensplan_dialog.dart';


void main() {
  runApp(const MyApp());
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
      initialRoute: '/',
      routes: {
        '/': (context) => const Startbildschirm(),
        '/speisekarte': (context) => const EssenDialog(),
        '/essensplan': (context) => const EssensplanDialog(),
      },
    );
  }
}