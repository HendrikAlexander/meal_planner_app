// lib/model/essens_datenbank.dart

import 'essen.dart';
import 'essens_art.dart';
import 'essensplan.dart';

class Essensdatenbank {
  Essensdatenbank._() {
    wochenplaene = List.generate(8, (wochenIndex) {
      return Essensplan(
        wochennummer: wochenIndex + 1,
        essenProWoche: (alleEssen.toList()..shuffle()).sublist(0, 5),
      );
    });
  }
  static final Essensdatenbank instance = Essensdatenbank._();

  List<Essen> alleEssen = [
    Essen(name: 'Spaghetti Carbonara', preis: 8.50, art: EssensArt.mitFleisch),
    Essen(name: 'Linsen-Curry', preis: 7.20, art: EssensArt.vegan),
    Essen(name: 'Käsespätzle', preis: 7.80, art: EssensArt.vegetarisch),
    Essen(name: 'Hähnchen süß-sauer', preis: 9.20, art: EssensArt.mitFleisch),
    Essen(name: 'Gemüse-Lasagne', preis: 8.90, art: EssensArt.vegetarisch),
    Essen(name: 'Falafel-Teller', preis: 6.50, art: EssensArt.vegan),
    Essen(name: 'Wiener Schnitzel', preis: 12.50, art: EssensArt.mitFleisch),
    Essen(name: 'Pizza Margherita', preis: 7.00, art: EssensArt.vegetarisch),
    Essen(name: 'Tofu-Pfanne', preis: 8.10, art: EssensArt.vegan),
    Essen(name: 'Rindergulasch', preis: 10.80, art: EssensArt.mitFleisch),
  ];

  late List<Essensplan> wochenplaene;

  void addEssen(Essen neuesEssen) {
    alleEssen.add(neuesEssen);
  }

  // GEÄNDERT: Die deleteEssen-Funktion wurde erweitert.
  void deleteEssen(Essen essen) {
    // Schritt 1: Aus der Master-Liste entfernen (wie bisher).
    alleEssen.remove(essen);

    // NEU - Schritt 2: Alle Wochenpläne durchgehen und das gelöschte Essen ebenfalls entfernen.
    for (final plan in wochenplaene) {
      // "removeWhere" entfernt alle Elemente, die die Bedingung erfüllen.
      // Wir vergleichen über den Namen, um sicherzugehen.
      plan.essenProWoche.removeWhere((item) => item.name == essen.name);
    }
  }

  void updateEssen(int index, Essen geaendertesEssen) {
    if (index >= 0 && index < alleEssen.length) {
      alleEssen[index] = geaendertesEssen;
    }
  }
}