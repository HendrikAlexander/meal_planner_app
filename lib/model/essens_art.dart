// lib/model/essens_art.dart
// Hier definieren wir die erlaubten Arten von Essen.
enum EssensArt {
  vegetarisch,
  vegan,
  mitFleisch,
}

// Diese "Extension" fügt unserem Enum eine nützliche Fähigkeit hinzu:
// Es kann sich selbst in einen schön lesbaren Text umwandeln.
extension EssensArtExtension on EssensArt {
  String get anzeigeName {
    switch (this) {
      case EssensArt.vegetarisch:
        return 'Vegetarisch';
      case EssensArt.vegan:
        return 'Vegan';
      case EssensArt.mitFleisch:
        return 'Mit Fleisch';
      default:
        return '';
    }
  }
}