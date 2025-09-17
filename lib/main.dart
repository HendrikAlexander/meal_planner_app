// lib/main.dart

import 'package:flutter/material.dart';
import 'package:meal_planner_app/l10n/app_localizations.dart';
import 'package:meal_planner_app/model/essens_datenbank.dart';
import 'package:meal_planner_app/viewmodel/EssensplanViewModel/essensplan_viewmodel.dart';
import 'package:meal_planner_app/viewmodel/SpeisekarteViewModel/essen_viewmodel.dart';
import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';



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
  // Essensdatenbank.instance.initializeMeals();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EssensplanViewModel()),
        ChangeNotifierProvider(create: (_) => EssensbewertungViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()), // NEU
        ChangeNotifierProvider(create: (_) => EssenViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(builder: (context, loginViewModel, child) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,

        
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate, // Dein Delegat für app_en.arb & app_de.arb
        GlobalMaterialLocalizations.delegate, // Für Material Widgets (z.B. OK, Abbrechen)
        GlobalWidgetsLocalizations.delegate, // Für Textrichtung (links-nach-rechts etc.)
        GlobalCupertinoLocalizations.delegate, // Für iOS-spezifische Widgets
      ],
      supportedLocales: const [
       Locale('en'), // Englisch
       Locale('de'), // Deutsch
     ],
      locale: loginViewModel.currentLocale,
      initialRoute: '/login', // <-- NEU: Login zuerst anzeigen
      // 🔑 Trick: Builder gibt uns einen gültigen Kontext,
          // sobald AppLocalizations verfügbar ist
         // builder: (context, child) {
            // Initialisierung nur 1x beim ersten Build
           // Essensdatenbank.instance.initializeMeals(context);
          //  return child!;
         // },
      routes: {
        '/': (context) => const Startbildschirm(),
        '/login': (context) => const LoginView(),
        '/speisekarte': (context) => const EssenDialog(),
        '/essensplan': (context) => const EssensplanDialog(),
        '/bewertungen': (context) => const BewertungDialog(),
      },
    );
     }, );
     }
}