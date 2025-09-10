// lib/model/essen.dart

import 'essens_art.dart';

class Essen {
  // GEÄNDERT: "final" wurde bei allen drei Eigenschaften entfernt.
  final String mealKey;
  final double preis;
  final EssensArt art;

  Essen({
    required this.mealKey,
    required this.preis,
    required this.art,
  });
}