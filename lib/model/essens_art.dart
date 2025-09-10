// lib/model/essens_art.dart
// Hier definieren wir die erlaubten Arten von Essen.
import 'package:flutter/material.dart';
import 'package:meal_planner_app/l10n/app_localizations.dart';

enum EssensArt {
  vegetarisch,
  vegan,
  mitFleisch,
}

// Diese "Extension" fügt unserem Enum eine nützliche Fähigkeit hinzu:
// Es kann sich selbst in einen schön lesbaren Text umwandeln.
extension EssensArtExtension on EssensArt {
  String localizedName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case EssensArt.vegetarisch:
        return l10n.vegetarian;
      case EssensArt.vegan:
        return l10n.vegan;
      case EssensArt.mitFleisch:
        return l10n.withMeat;
    }
  }
}