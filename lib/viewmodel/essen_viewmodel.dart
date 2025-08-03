import '../model/essen.dart';

class EssenViewModel {

  final List<Essen> essenListe = [
    Essen(name: 'Spaghetti Carbonara', preis: 8.50, art: 'mit Fleisch'),
    Essen(name: 'Linsen-Curry', preis: 7.20, art: 'vegan'),
    Essen(name: 'Käsespätzle', preis: 7.80, art: 'vegetarisch'),
    Essen(name: 'Hähnchen süß-sauer', preis: 9.20, art: 'mit Fleisch'),
    Essen(name: 'Gemüse-Lasagne', preis: 8.90, art: 'vegetarisch'),
    Essen(name: 'Falafel-Teller', preis: 6.50, art: 'vegan'),
    Essen(name: 'Wiener Schnitzel', preis: 12.50, art: 'mit Fleisch'),
    Essen(name: 'Pizza Margherita', preis: 7.00, art: 'vegetarisch'),
    Essen(name: 'Tofu-Pfanne', preis: 8.10, art: 'vegan'),
    Essen(name: 'Rindergulasch', preis: 10.80, art: 'mit Fleisch'),
  ];
}