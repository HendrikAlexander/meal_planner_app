// lib/model/essen.dart

import 'essens_art.dart';

class Essen {
  // GEÄNDERT: "final" wurde bei allen drei Eigenschaften entfernt.
  String name;
  double preis;
  EssensArt art;

  Essen({
    required this.name,
    required this.preis,
    required this.art,
  });
}