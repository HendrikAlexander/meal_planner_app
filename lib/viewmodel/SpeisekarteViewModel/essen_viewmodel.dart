// lib/viewmodel/SpeisekarteViewModel/essen_viewmodel.dart

import 'package:flutter/material.dart';

import '../../model/essen.dart';
import '../../model/essens_datenbank.dart';

class EssenViewModel extends ChangeNotifier{
  final Essensdatenbank _datenbank = Essensdatenbank.instance;

  List<Essen> get essenListe => _datenbank.speisekarte;

  EssenViewModel();

  // GEÄNDERT: Alle Funktionen rufen jetzt die zentralen Funktionen der Datenbank auf.
  void addEssen(Essen neuesEssen) {
    _datenbank.addEssen(neuesEssen);
    notifyListeners();
  }

  void deleteEssen(Essen essen) {
    _datenbank.deleteEssen(essen);
    notifyListeners();
  }

  void updateEssen(int index, Essen geaendertesEssen) {
    _datenbank.updateEssen(index, geaendertesEssen);
    notifyListeners();
  }
}