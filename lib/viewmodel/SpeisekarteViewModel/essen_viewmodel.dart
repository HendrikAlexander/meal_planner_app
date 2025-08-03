// lib/viewmodel/SpeisekarteViewModel/essen_viewmodel.dart

import '../../model/essen.dart';
import '../../model/essens_datenbank.dart';

class EssenViewModel {
  final Essensdatenbank _datenbank = Essensdatenbank.instance;

  List<Essen> get essenListe => _datenbank.alleEssen;

  EssenViewModel();

  // GEÄNDERT: Alle Funktionen rufen jetzt die zentralen Funktionen der Datenbank auf.
  void addEssen(Essen neuesEssen) {
    _datenbank.addEssen(neuesEssen);
  }

  void deleteEssen(Essen essen) {
    _datenbank.deleteEssen(essen);
  }

  void updateEssen(int index, Essen geaendertesEssen) {
    _datenbank.updateEssen(index, geaendertesEssen);
  }
}