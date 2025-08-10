// lib/view/essen_dialog.dart

import 'package:flutter/material.dart';
import '../../model/essen.dart';
import '../../model/essens_art.dart';
import '../../viewmodel/SpeisekarteViewModel/essen_viewmodel.dart';
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
    final geaendertesEssen = await showDialog<Essen>(
      context: context,
      builder: (BuildContext context) {
        // Dialog im "Bearbeiten"-Modus → aktuelles Essen übergeben
        return AddEssenDialog(essen: altesEssen);
      },
    );
    if (geaendertesEssen != null) {
      setState(() {
        // Geändertes Essen im ViewModel aktualisieren
        viewModel.updateEssen(index, geaendertesEssen);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speisekarte'),
      ),
      body: ListView.builder(
        itemCount: viewModel.essenListe.length,
        itemBuilder: (context, index) {
          final essen = viewModel.essenListe[index];
          return Dismissible(
            key: Key(essen.name + index.toString()),
            direction: DismissDirection.endToStart, // Nur von rechts nach links
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            // Wenn Wischen abgeschlossen ist → Essen löschen
            onDismissed: (direction) {
              _einEssenLoeschen(essen);
            },
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
            child: ListTile(
              title: Text(essen.name), // Name des Essens
              subtitle: Text(essen.art.anzeigeName), // Art des Essens (z. B. vegetarisch)
              trailing: Text('${essen.preis.toStringAsFixed(2)} €'),
              // Tippen auf die Kachel → Essen bearbeiten
              onTap: () {
                _einEssenBearbeiten(essen, index);
              },
            ),
          );
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
