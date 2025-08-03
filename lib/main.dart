// lib/main.dart

import 'package:flutter/material.dart';
// Wir importieren unsere neue "Speisekarte", damit wir sie verwenden können.
import 'view/essen_dialog.dart';

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
      // Hier legen wir fest, was der Startbildschirm unserer App ist.
      // Wir setzen hier eine Instanz unseres neuen EssenDialogs ein.
      home: EssenDialog(),
    );
  }
}