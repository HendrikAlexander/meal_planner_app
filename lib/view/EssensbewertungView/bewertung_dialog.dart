// lib/view/EssensbewertungView/bewertung_dialog.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:meal_planner_app/l10n/app_localizations.dart';
import 'package:meal_planner_app/model/essens_datenbank.dart';
import 'package:meal_planner_app/model/user.dart';
import 'package:meal_planner_app/viewmodel/LoginViewModel/login_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/EssensbewertungViewModel/essensbewertung_viewmodel.dart';
import '../../model/essensbewertung.dart';
import 'add_bewertung_dialog.dart';

/// Ansicht zur Anzeige aller abgegebenen Bewertungen mit Bearbeitungsfunktion
class BewertungDialog extends StatelessWidget {
  const BewertungDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bewertungenViewModel = Provider.of<EssensbewertungViewModel>(context);
    final bewertungen = bewertungenViewModel.bewertungen;
    final isAdmin = Provider.of<LoginViewModel>(context, listen: false).currentRole == UserRole.admin;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.allReviewsTitle),
      ),
      body: bewertungen.isEmpty
          ? Center(child: Text(l10n.noReviewsAvailable))
          : ListView.builder(
              itemCount: bewertungen.length,
              itemBuilder: (context, index) {
                final bewertung = bewertungen[index];
                 final translatedMealName = getTranslatedMealName(bewertung.essenMealKey, l10n);

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('"$translatedMealName"'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Essen-Name anzeigen
                        Text(l10n.starsRating(bewertung.essensbewertung.toString())),
                        const SizedBox(height: 4),
                        Text('"${bewertung.essensbewertungstext}"'),
                        const SizedBox(height: 4),
                        Text(l10n.reviewBy(bewertung.erstelltVon)),
                        const SizedBox(height: 8),
                        // Zeige Bild, falls vorhanden
                        if (bewertung.essensfoto.isNotEmpty)
                          Image.file(
                            File(bewertung.essensfoto),
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                      ],
                    ),
                    // Nur Admins können Bewertungen bearbeiten und löschen
                    trailing: isAdmin
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () async {
                                  final neueBewertung = await showDialog<Essensbewertung>(
                                    context: context,
                                    builder: (context) => AddBewertungDialog(
                                      vorhandeneBewertung: bewertung,
                                    ),
                                  );

                                  if (neueBewertung != null) {
                                    bewertungenViewModel.bewertungAendern(index, neueBewertung);
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(l10n.deleteReviewTitle),
                                      content: Text(l10n.deleteReviewContent),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text(l10n.cancelButton),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            bewertungenViewModel.bewertungEntfernen(index);
                                            Navigator.pop(context);
                                          },
                                          child: Text(l10n.deleteButton),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        : null
                  ),
                );
              },
            ),
    );
  }
}
