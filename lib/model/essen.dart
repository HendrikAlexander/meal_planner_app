// lib/model/essen.dart

import 'essens_art.dart';

class Essen {

  final String mealKey;
  final double preis;
  final EssensArt art;
  final String? nameDe;
  final String? nameEn;

  Essen({
    required this.mealKey,
    required this.preis,
    required this.art,
    this.nameDe,
    this.nameEn,
  });
}