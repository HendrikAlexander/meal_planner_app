// lib/viewmodel/EssensplanViewModel/essensplan_viewmodel.dart

import 'package:flutter/material.dart';

import '../../model/essens_datenbank.dart';
import '../../model/essensplan.dart';

class EssensplanViewModel extends ChangeNotifier {
   List<Essensplan> wochenplaene = [];


  final Essensdatenbank _datenbank = Essensdatenbank.instance;



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
   


  void addEssensplan(Essensplan neuerPlan) {
    wochenplaene.add(neuerPlan);
    notifyListeners();
  }


  void updateEssensplan(int index, Essensplan geaenderterPlan) {
    if (index >= 0 && index < wochenplaene.length) {
      wochenplaene[index] = geaenderterPlan;
      notifyListeners();
    }
  }


  void deleteEssensplan(Essensplan plan) {
    wochenplaene.remove(plan);
  }
}