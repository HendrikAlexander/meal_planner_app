import 'package:flutter/material.dart';
import '../../model/essensbewertung.dart';


class EssensbewertungViewModel extends ChangeNotifier {

  final List<Essensbewertung> _bewertungen = [];


  List<Essensbewertung> get bewertungen => _bewertungen;


  void bewertungHinzufuegen(Essensbewertung bewertung) {
    _bewertungen.add(bewertung);
    notifyListeners(); 
  }


  void bewertungAendern(int index, Essensbewertung neueBewertung) {
    _bewertungen[index] = neueBewertung;
    notifyListeners();
  }


  void bewertungEntfernen(int index) {
      _bewertungen.removeAt(index);
      notifyListeners();
  }
  
}
