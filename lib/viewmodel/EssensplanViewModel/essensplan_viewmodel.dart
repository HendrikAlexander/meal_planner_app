// lib/viewmodel/EssensplanViewModel/essensplan_viewmodel.dart

import '../../model/essens_datenbank.dart';
import '../../model/essensplan.dart';

class EssensplanViewModel {
  // Greift auf die EINE zentrale Instanz der Datenbank zu.
  final Essensdatenbank _datenbank = Essensdatenbank.instance;

  // Verweis auf die Liste der Wochenpläne in der Datenbank.
  List<Essensplan> get wochenplaene => _datenbank.wochenplaene;

  EssensplanViewModel();

  // Fügt einen neuen Wochenplan zur Liste hinzu.
  void addEssensplan(Essensplan neuerPlan) {
    _datenbank.wochenplaene.add(neuerPlan);
  }

  // Aktualisiert einen Wochenplan an einer bestimmten Position in der Liste.
  void updateEssensplan(int index, Essensplan geaenderterPlan) {
    if (index >= 0 && index < _datenbank.wochenplaene.length) {
      _datenbank.wochenplaene[index] = geaenderterPlan;
    }
  }

  // Entfernt einen Wochenplan aus der Liste.
  void deleteEssensplan(Essensplan plan) {
    _datenbank.wochenplaene.remove(plan);
  }
}