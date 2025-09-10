class Essensbewertung {
  final String essenMealKey;

  final String essensfoto;
  final int essensbewertung;
  final String essensbewertungstext;
  final String erstelltVon;    // 👤 Name/Benutzer, der die Bewertung abgegeben hat


  Essensbewertung({
    required this.essenMealKey,
    required this.essensfoto,
    required this.essensbewertung,
    required this.essensbewertungstext,
    required this.erstelltVon
  });
}