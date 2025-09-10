// lib/model/essens_datenbank.dart

import 'package:flutter/material.dart';
import 'package:meal_planner_app/l10n/app_localizations.dart';

import 'essen.dart';
import 'essens_art.dart';
import 'essensplan.dart';

class Essensdatenbank {
  
  static final Essensdatenbank instance = Essensdatenbank._internal();
   Essensdatenbank._internal();
  final List<Essen> _speisekarte = [];
  bool _isInitialized = false;
  
  List<Essen> get speisekarte => _speisekarte;

// List<Essen> alleEssen = [];
//  List<Essensplan> wochenplaene = [];

  // static final Essensdatenbank instance = Essensdatenbank._();

  void initializeMeals() {
    if (_isInitialized) return;
    // Hole das Lokalisierungsobjekt aus dem Kontext
  //  final l10n = AppLocalizations.of(context)!;

  _speisekarte.addAll([
      Essen(mealKey: 'spaghettiCarbonara', preis: 9.50, art: EssensArt.mitFleisch),
      Essen(mealKey: 'linsenCurry', preis: 8.00, art: EssensArt.vegan),
      Essen(mealKey: 'kaesespaetzle', preis: 8.50, art: EssensArt.vegetarisch),
      Essen(mealKey: 'haehnchenSuessSauer', preis: 10.20, art: EssensArt.mitFleisch),
      Essen(mealKey: 'gemueseLasagne', preis: 9.00, art: EssensArt.vegetarisch),
      Essen(mealKey: 'falafelTeller', preis: 7.80, art: EssensArt.vegan),
      Essen(mealKey: 'wienerSchnitzel', preis: 12.50, art: EssensArt.mitFleisch),
      Essen(mealKey: 'pizzaMargherita', preis: 7.50, art: EssensArt.vegetarisch),
      Essen(mealKey: 'tofuPfanne', preis: 8.20, art: EssensArt.vegan),
      Essen(mealKey: 'rindergulasch', preis: 11.00, art: EssensArt.mitFleisch),
    ]);
     _isInitialized = true;
      }
      
  //wochenplaene = List.generate(8, (wochenIndex) {
    // return Essensplan(
     //   wochennummer: wochenIndex + 1,
     //   essenProWoche: (alleEssen.toList()..shuffle()).sublist(0, 5),
     // );
     // });
  void addEssen(Essen neuesEssen) {
    _speisekarte.add(neuesEssen);
  }

  // GEÄNDERT: Die deleteEssen-Funktion wurde erweitert.
  void deleteEssen(Essen essen) {
    // Schritt 1: Aus der Master-Liste entfernen (wie bisher).
    _speisekarte.remove(essen);

    // NEU - Schritt 2: Alle Wochenpläne durchgehen und das gelöschte Essen ebenfalls entfernen.
   // for (final plan in wochenplaene) {
      // "removeWhere" entfernt alle Elemente, die die Bedingung erfüllen.
      // Wir vergleichen über den Namen, um sicherzugehen.
    //  plan.essenProWoche.removeWhere((item) => item.name == essen.name);
   // }
  }

  void updateEssen(int index, Essen geaendertesEssen) {
    if (index >= 0 && index < _speisekarte.length) {
      _speisekarte[index] = geaendertesEssen;
    }
  }
} 
// --- 3. HELFER-FUNKTIONEN ---
// Diese Funktion übersetzt den Namen des Gerichts.
String getTranslatedMealName(String mealKey, AppLocalizations l10n) {
  switch (mealKey) {
    case 'spaghettiCarbonara':
      return l10n.spaghettiCarbonara;
    case 'linsenCurry':
      return l10n.linsenCurry;
    case 'kaesespaetzle':
      return l10n.kaesespaetzle;
    case 'haehnchenSuessSauer':
      return l10n.haehnchenSuessSauer;
    case 'gemueseLasagne':
      return l10n.gemueseLasagne;
    case 'falafelTeller':
      return l10n.falafelTeller;
    case 'wienerSchnitzel':
      return l10n.wienerSchnitzel;
    case 'pizzaMargherita':
      return l10n.pizzaMargherita;
    case 'tofuPfanne':
      return l10n.tofuPfanne;
    case 'rindergulasch':
      return l10n.rindergulasch;
    default:
      return 'Unknown Meal'; // Fallback
  }
}

// NEU: Diese Funktion übersetzt die Art des Gerichts.
String getTranslatedArtName(EssensArt art, AppLocalizations l10n) {
  switch (art) {
    case EssensArt.vegetarisch:
      return l10n.vegetarian;
    case EssensArt.vegan:
      return l10n.vegan;
    case EssensArt.mitFleisch:
      return l10n.withMeat;
  }
}

