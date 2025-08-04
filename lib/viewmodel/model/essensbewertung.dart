/// Modellklasse für eine Essensbewertung
class Essensbewertung {
  final String essensfoto; // Pfad zum Foto (später mit Kamera aufgenommen)
  final int essensbewertung; // Bewertungsskala (z. B. 1 bis 5)
  final String essensbewertungstext; // Freitext zur Bewertung

  Essensbewertung({
    required this.essensfoto,
    required this.essensbewertung,
    required this.essensbewertungstext,
  });
}
