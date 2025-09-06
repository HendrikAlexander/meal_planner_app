class Essensbewertung {

  final String essensfoto;
  final int essensbewertung;
  final String essensbewertungstext;
  final String essenName;
    final String erstelltVon;    // Name/Benutzer, der die Bewertung abgegeben hat


  Essensbewertung({
    required this.essensfoto,
    required this.essensbewertung,
    required this.essensbewertungstext,
    required this.essenName,
    required this.erstelltVon
  });
}