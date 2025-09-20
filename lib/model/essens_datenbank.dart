import 'package:meal_planner_app/l10n/app_localizations.dart';
import 'essen.dart';
import 'essens_art.dart';

class Essensdatenbank {
  static final Essensdatenbank instance = Essensdatenbank._internal();

  final List<Essen> _speisekarte = [
    Essen(mealKey: 'spaghettiCarbonara', preis: 9.50, art: EssensArt.mitFleisch, nameDe: 'Spaghetti Carbonara', nameEn: 'Spaghetti Carbonara'),
    Essen(mealKey: 'linsenCurry', preis: 8.00, art: EssensArt.vegan, nameDe: 'Linsen-Curry', nameEn: 'Lentil Curry'),
    Essen(mealKey: 'kaesespaetzle', preis: 8.50, art: EssensArt.vegetarisch, nameDe: 'Käsespätzle', nameEn: 'Cheese Spaetzle'),
    Essen(mealKey: 'haehnchenSuessSauer', preis: 10.20, art: EssensArt.mitFleisch, nameDe: 'Hähnchen süß-sauer', nameEn: 'Sweet and Sour Chicken'),
    Essen(mealKey: 'gemueseLasagne', preis: 9.00, art: EssensArt.vegetarisch, nameDe: 'Gemüse-Lasagne', nameEn: 'Vegetable Lasagna'),
    Essen(mealKey: 'falafelTeller', preis: 7.80, art: EssensArt.vegan, nameDe: 'Falafel-Teller', nameEn: 'Falafel Plate'),
    Essen(mealKey: 'wienerSchnitzel', preis: 12.50, art: EssensArt.mitFleisch, nameDe: 'Wiener Schnitzel', nameEn: 'Viennese Schnitzel'),
    Essen(mealKey: 'pizzaMargherita', preis: 7.50, art: EssensArt.vegetarisch, nameDe: 'Pizza Margherita', nameEn: 'Margherita Pizza'),
    Essen(mealKey: 'tofuPfanne', preis: 8.20, art: EssensArt.vegan, nameDe: 'Tofu-Pfanne', nameEn: 'Tofu Stir-fry'),
    Essen(mealKey: 'rindergulasch', preis: 11.00, art: EssensArt.mitFleisch, nameDe: 'Rindergulasch', nameEn: 'Beef Goulash'),
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
    
    final idx = _speisekarte.indexWhere((e) => e.mealKey == neuesEssen.mealKey);
    if (idx != -1) {
      _speisekarte[idx] = neuesEssen;
    }
  }
}


String getTranslatedMealName(String mealKey, AppLocalizations l10n, {String? fallbackName, Essen? essen}) {
  
  const standardKeys = [
    'spaghettiCarbonara',
    'linsenCurry',
    'kaesespaetzle',
    'haehnchenSuessSauer',
    'gemueseLasagne',
    'falafelTeller',
    'wienerSchnitzel',
    'pizzaMargherita',
    'tofuPfanne',
    'rindergulasch',
  ];

  
  if (essen != null) {
    if (l10n.localeName.startsWith('de')) {
      
      if (essen.nameDe != null && essen.nameDe!.trim().isNotEmpty) {
        
        if (!standardKeys.contains(mealKey) || essen.nameDe!.trim() != _getStandardNameDe(mealKey, l10n)) {
          return essen.nameDe!;
        }
      }
    } else {
      if (essen.nameEn != null && essen.nameEn!.trim().isNotEmpty) {
        if (!standardKeys.contains(mealKey) || essen.nameEn!.trim() != _getStandardNameEn(mealKey, l10n)) {
          return essen.nameEn!;
        }
      }
    }
  }

  
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
  }
  
  if (essen != null) {
    if (l10n.localeName.startsWith('de')) {
      return essen.nameDe ?? fallbackName ?? l10n.unknownMeal;
    } else {
      return essen.nameEn ?? fallbackName ?? l10n.unknownMeal;
    }
  }
  return fallbackName != null && fallbackName.isNotEmpty ? fallbackName : l10n.unknownMeal;
}


String _getStandardNameDe(String mealKey, AppLocalizations l10n) {
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
    default: return '';
  }
}
String _getStandardNameEn(String mealKey, AppLocalizations l10n) {
  
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
    default: return '';
  }
}