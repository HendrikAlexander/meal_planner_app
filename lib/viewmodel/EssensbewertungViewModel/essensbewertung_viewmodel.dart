import 'package:flutter/material.dart';
import '../../model/essensbewertung.dart';

/// ViewModel zur Verwaltung von Essensbewertungen.
/// Diese Klasse hält eine Liste von Bewertungen und informiert das UI bei Änderungen.
class EssensbewertungViewModel extends ChangeNotifier {
  // Interne Liste aller abgegebenen Bewertungen
  final List<Essensbewertung> _bewertungen = [];

  // Getter für die Bewertungen – für die Anzeige im UI
  List<Essensbewertung> get bewertungen => _bewertungen;

  /// Fügt eine neue Bewertung hinzu und informiert alle Listener (z. B. das UI)
  void bewertungHinzufuegen(Essensbewertung bewertung) {
    _bewertungen.add(bewertung);
    notifyListeners(); // UI wird automatisch aktualisiert
  }

  /// Ändert eine Bewertung an einer bestimmten Position
  void bewertungAendern(int index, Essensbewertung neueBewertung) {
    _bewertungen[index] = neueBewertung;
    notifyListeners();
  }
}
