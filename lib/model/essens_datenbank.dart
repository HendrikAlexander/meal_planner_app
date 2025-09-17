import 'package:meal_planner_app/l10n/app_localizations.dart';
import 'essen.dart';
import 'essens_art.dart';

class Essensdatenbank {
  static final Essensdatenbank instance = Essensdatenbank._internal();

  final List<Essen> _speisekarte = [
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
  ];

  Essensdatenbank._internal();

  List<Essen> get speisekarte => _speisekarte;

  void addEssen(Essen neuesEssen) {
    _speisekarte.add(neuesEssen);
  }

  void deleteEssen(Essen essen) {
    _speisekarte.removeWhere((item) => item.mealKey == essen.mealKey);
  }

  void updateEssen(int index, Essen neuesEssen) {
    if (index >= 0 && index < _speisekarte.length) {
      _speisekarte[index] = neuesEssen;
    }
  }
}

// Helfer-Funktionen
String getTranslatedMealName(String mealKey, AppLocalizations l10n, {String? fallbackName}) {
  switch (mealKey) {
    case 'spaghettiCarbonara': return l10n.spaghettiCarbonara;
    case 'linsenCurry': return l10n.linsenCurry;
    case 'kaesespaetzle': return l10n.kaesespaetzle;
    case 'haehnchenSuessSauer': return l10n.haehnchenSuessSauer;
    case 'gemueseLasagne': return l10n.gemueseLasagne;
    case 'falafelTeller': return l10n.falafelTeller;
    case 'wienerSchnitzel': return l10n.wienerSchnitzel;
    case 'pizzaMargherita': return l10n.pizzaMargherita;
    case 'tofuPfanne': return l10n.tofuPfanne;
    case 'rindergulasch': return l10n.rindergulasch;
    default:
      return fallbackName != null && fallbackName.isNotEmpty ? fallbackName : l10n.unknownMeal;
  }
}

String getTranslatedArtName(EssensArt art, AppLocalizations l10n) {
  switch (art) {
    case EssensArt.vegetarisch: return l10n.vegetarian;
    case EssensArt.vegan: return l10n.vegan;
    case EssensArt.mitFleisch: return l10n.withMeat;
  }
}