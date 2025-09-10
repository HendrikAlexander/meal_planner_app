// lib/viewmodel/EssensplanViewModel/essensplan_viewmodel.dart

import 'package:flutter/material.dart';

import '../../model/essens_datenbank.dart';
import '../../model/essensplan.dart';

class EssensplanViewModel extends ChangeNotifier {
   List<Essensplan> wochenplaene = [];

  // Greift auf die EINE zentrale Instanz der Datenbank zu.
  final Essensdatenbank _datenbank = Essensdatenbank.instance;

  // Verweis auf die Liste der Wochenpläne in der Datenbank.
  // List<Essensplan> get wochenplaene => _datenbank.wochenplaene;

  EssensplanViewModel(){
     erstelleWochenplaene();
  }
   void erstelleWochenplaene() {
    final alleEssen = _datenbank.speisekarte;

    if (alleEssen.length < 5) return;
   
    wochenplaene = List.generate(8, (wochenIndex) {
      return Essensplan(
        wochennummer: wochenIndex + 1,
          essenProWoche: (alleEssen.toList()..shuffle()).sublist(0, 5),
              );
              });
    }
   

  // Fügt einen neuen Wochenplan zur Liste hinzu.
  void addEssensplan(Essensplan neuerPlan) {
    wochenplaene.add(neuerPlan);
    notifyListeners();
  }

  // Aktualisiert einen Wochenplan an einer bestimmten Position in der Liste.
  void updateEssensplan(int index, Essensplan geaenderterPlan) {
    if (index >= 0 && index < wochenplaene.length) {
      wochenplaene[index] = geaenderterPlan;
      notifyListeners();
    }
  }

  // Entfernt einen Wochenplan aus der Liste.
  void deleteEssensplan(Essensplan plan) {
    wochenplaene.remove(plan);
  }
}