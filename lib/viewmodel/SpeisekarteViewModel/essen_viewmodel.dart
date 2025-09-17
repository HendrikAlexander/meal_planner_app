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
    _essenListe.add(neuesEssen);
    notifyListeners();
  }

  void deleteEssen(Essen essen) {
    _datenbank.deleteEssen(essen);
    _essenListe.removeWhere((item) => item.mealKey == essen.mealKey);
    notifyListeners();
  }

  void updateEssen(int index, Essen neuesEssen) {
    if (index >= 0 && index < _essenListe.length) {
      _datenbank.updateEssen(index, neuesEssen);
      _essenListe[index] = neuesEssen;
      notifyListeners();
    }
  }
}