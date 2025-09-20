// lib/main.dart
import 'package:flutter/material.dart';
import 'package:meal_planner_app/l10n/app_localizations.dart';
import 'package:meal_planner_app/viewmodel/EssensplanViewModel/essensplan_viewmodel.dart';
import 'package:meal_planner_app/viewmodel/SpeisekarteViewModel/essen_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'view/SpeisekarteView/essen_dialog.dart';
import 'view/Startseite/startbildschirm.dart';
import 'view/EssensplanView/essensplan_dialog.dart';
import 'view/EssensbewertungView/bewertung_dialog.dart';
import 'viewmodel/EssensbewertungViewModel/essensbewertung_viewmodel.dart';
import 'view/LoginView/login_view.dart';
import 'viewmodel/LoginViewModel/login_viewmodel.dart';

void main() {
  
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
        AppLocalizations.delegate, 
        GlobalMaterialLocalizations.delegate, 
        GlobalWidgetsLocalizations.delegate, 
        GlobalCupertinoLocalizations.delegate, 
      ],
      supportedLocales: const [
       Locale('en'), // Englisch
       Locale('de'), // Deutsch
     ],
      locale: loginViewModel.currentLocale,
      initialRoute: '/login', 
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