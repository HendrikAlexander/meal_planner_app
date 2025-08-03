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
    // ... (restliche Essen wie gehabt)
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

  // --- NEUE ZENTRALE FUNKTIONEN ---
  void addEssen(Essen neuesEssen) {
    alleEssen.add(neuesEssen);
  }

  void deleteEssen(Essen essen) {
    alleEssen.remove(essen);
  }

  void updateEssen(int index, Essen geaendertesEssen) {
    if (index >= 0 && index < alleEssen.length) {
      alleEssen[index] = geaendertesEssen;
    }
  }
}