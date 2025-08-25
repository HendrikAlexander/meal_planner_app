// lib/view/SpeisekarteView/essen_dialog.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:meal_planner_app/model/user.dart';
import 'package:meal_planner_app/viewmodel/LoginViewModel/login_viewmodel.dart';

import '../../model/essen.dart';
import '../../model/essens_art.dart';
import '../../viewmodel/SpeisekarteViewModel/essen_viewmodel.dart';
import '../EssensbewertungView/add_bewertung_dialog.dart';
import 'add_essen_dialog.dart';

/// Bildschirm zur Anzeige und Verwaltung der Speisekarte
/// Hier können neue Essen hinzugefügt, bearbeitet, gelöscht
/// und Bewertungen abgegeben werden.
class EssenDialog extends StatefulWidget {
  const EssenDialog({super.key});

  @override
  State<EssenDialog> createState() => _EssenDialogState();
}

class _EssenDialogState extends State<EssenDialog> {
  // ViewModel verwaltet die Liste der Essen
  final EssenViewModel viewModel = EssenViewModel();

  /// Öffnet den Dialog zum Hinzufügen eines neuen Essens
  void _einNeuesEssenHinzufuegen() async {
    final neuesEssen = await showDialog<Essen>(
      context: context,
      builder: (BuildContext context) {
        // Dialog im "Erstellen"-Modus → kein Essen übergeben
        return const AddEssenDialog();
      },
    );
    if (neuesEssen != null) {
      setState(() {
        // Neues Essen ins ViewModel hinzufügen
        viewModel.addEssen(neuesEssen);
      });
    }
  }

  /// Öffnet den Dialog zum Bearbeiten eines bestehenden Essens
  void _einEssenBearbeiten(Essen altesEssen, int index) async {
    // Das Ergebnis des Dialogs abwarten. Es kann jetzt ein Essen, ein String oder null sein.
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        // Dialog im "Bearbeiten"-Modus → aktuelles Essen übergeben
        return AddEssenDialog(essen: altesEssen);
      },
    );

    // Nichts tun, wenn der Benutzer auf "Abbrechen" geklickt hat (result ist dann null)
    if (result == null) return;

    // Prüfen, welches Ergebnis zurückkam (Löschen oder Bearbeiten)
    if (result == 'DELETE_ACTION') {
      // Wenn das Löschen-Signal kommt, die bereits existierende Löschen-Funktion aufrufen
      _einEssenLoeschen(altesEssen);
    } else if (result is Essen) {
      // Wenn ein geändertes Essen zurückkommt, die UI mit dem neuen Objekt aktualisieren
      setState(() {
        // Geändertes Essen im ViewModel aktualisieren
        viewModel.updateEssen(index, result);
      });
    }
  }

  /// Löscht ein Essen aus der Liste
  void _einEssenLoeschen(Essen essen) {
    setState(() {
      viewModel.deleteEssen(essen);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Rollenermittlung: Admin darf löschen (Swipe-to-Delete), alle dürfen bewerten
    final isAdmin =
        Provider.of<LoginViewModel>(context, listen: false).currentRole ==
            UserRole.admin;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Speisekarte'),
      ),
      body: ListView.builder(
        itemCount: viewModel.essenListe.length,
        itemBuilder: (context, index) {
          final essen = viewModel.essenListe[index];

          // Kachel-Inhalt: gemeinsam für Admin & Nicht-Admin
          final tile = ListTile(
            title: Text(essen.name),                  // Name des Essens
            subtitle: Text(essen.art.anzeigeName),    // Art des Essens (z. B. vegetarisch)
            // ⬇️ PREIS + BUTTON "Bewertung abgeben"
            trailing: Wrap(
              spacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('${essen.preis.toStringAsFixed(2)} €'), // Preis
                IconButton(
                  tooltip: 'Bewertung abgeben',
                  icon: const Icon(Icons.rate_review),
                  onPressed: () {
                    // Bewertungsdialog öffnen und das aktuelle Essen mitgeben
                    showDialog(
                      context: context,
                      builder: (context) => AddBewertungDialog(
                        essen: essen, // wichtig: so wird essenName korrekt gespeichert
                      ),
                    );
                  },
                ),
              ],
            ),
            // Tippen auf die Kachel → Essen bearbeiten
            onTap: () {
              _einEssenBearbeiten(essen, index);
            },
          );

          if (isAdmin) {
            // Admins dürfen löschen (Swipe to delete)
            return Dismissible(
              key: Key(essen.name + index.toString()),
              direction: DismissDirection.endToStart, // Nur von rechts nach links
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              // Sicherheitsabfrage vor dem Löschen
              confirmDismiss: (direction) async {
                return await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Bestätigung'),
                      content: Text('Möchten Sie "${essen.name}" wirklich löschen?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Abbrechen'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Löschen'),
                        ),
                      ],
                    );
                  },
                );
              },
              onDismissed: (direction) {
                _einEssenLoeschen(essen);
              },
              child: tile,
            );
          } else {
            // Nur lesender Zugriff für Nicht-Admins
            return tile;
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _einNeuesEssenHinzufuegen,
        tooltip: 'Essen hinzufügen',
        child: const Icon(Icons.add),
      ),
    );
  }
}
