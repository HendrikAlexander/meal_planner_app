// lib/view/SpeisekarteView/bewertungen_liste.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/essensbewertung_viewmodel.dart';
import '../../model/essensbewertung.dart';
import 'add_bewertung_dialog.dart';

/// Ansicht zur Anzeige aller abgegebenen Bewertungen mit Bearbeitungsfunktion
class BewertungenListe extends StatelessWidget {
  const BewertungenListe({super.key});

  @override
  Widget build(BuildContext context) {
    final bewertungenViewModel = Provider.of<EssensbewertungViewModel>(context);
    final bewertungen = bewertungenViewModel.bewertungen;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alle Bewertungen'),
      ),
      body: bewertungen.isEmpty
          ? const Center(child: Text('Keine Bewertungen vorhanden.'))
          : ListView.builder(
              itemCount: bewertungen.length,
              itemBuilder: (context, index) {
                final bewertung = bewertungen[index];

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Bewertung: ${bewertung.essensbewertung} Stern'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Essen-Name anzeigen
                        Text('Essen: ${bewertung.essenName}'),
                        Text('Erstellt von: ${bewertung.erstelltVon}'),
                        Text('Kommentar: ${bewertung.essensbewertungstext}'),
                        const SizedBox(height: 8),
                        // 📸 Zeige Bild, falls vorhanden
                        if (bewertung.essensfoto.isNotEmpty)
                          Image.file(
                            File(bewertung.essensfoto),
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                      ],
                    ),
                    //Button zum Bearbeiten
                    trailing: IconButton(
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
                  ),
                );
              },
            ),
    );
  }
}
