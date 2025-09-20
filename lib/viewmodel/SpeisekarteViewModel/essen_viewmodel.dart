import 'package:flutter/material.dart';
import '../../model/essen.dart';
import '../../model/essens_datenbank.dart';

class EssenViewModel extends ChangeNotifier {
  final Essensdatenbank _datenbank = Essensdatenbank.instance;
  late List<Essen> _essenListe;

  List<Essen> get essenListe => _essenListe;

  EssenViewModel() {
    _essenListe = List.from(_datenbank.speisekarte);
  }

  void addEssen(Essen neuesEssen) {
    _datenbank.addEssen(neuesEssen);
    _essenListe = List.from(_datenbank.speisekarte); 
    notifyListeners();
  }

  void deleteEssen(Essen essen) {
    _datenbank.deleteEssen(essen);
    _essenListe = List.from(_datenbank.speisekarte); 
    notifyListeners();
  }

  void updateEssen(int index, Essen neuesEssen) {
    // Suche das Essen anhand des mealKey
    final idx = _essenListe.indexWhere((e) => e.mealKey == neuesEssen.mealKey);
    if (idx != -1) {
      _datenbank.updateEssen(idx, neuesEssen);
      _essenListe = List.from(_datenbank.speisekarte); 
      notifyListeners();
    }
  }
}