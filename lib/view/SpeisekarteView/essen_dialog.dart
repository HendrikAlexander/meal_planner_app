// lib/view/SpeisekarteView/essen_dialog.dart

import 'package:flutter/material.dart';
import 'package:meal_planner_app/model/user.dart';
import 'package:meal_planner_app/viewmodel/LoginViewModel/login_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../model/essen.dart';
import '../../model/essens_art.dart';
import '../../viewmodel/SpeisekarteViewModel/essen_viewmodel.dart';
import 'add_essen_dialog.dart';

class EssenDialog extends StatefulWidget {
  const EssenDialog({super.key});

  @override
  State<EssenDialog> createState() => _EssenDialogState();
}

class _EssenDialogState extends State<EssenDialog> {
  final EssenViewModel viewModel = EssenViewModel();

  void _einNeuesEssenHinzufuegen() async {
    final neuesEssen = await showDialog<Essen>(
      context: context,
      builder: (BuildContext context) {
        return const AddEssenDialog();
      },
    );
    if (neuesEssen != null) {
      setState(() {
        viewModel.addEssen(neuesEssen);
      });
    }
  }

  // MODIFIED: This function now handles the "DELETE" signal
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

  void _einEssenLoeschen(Essen essen) {
    setState(() {
      viewModel.deleteEssen(essen);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin =
        Provider.of<LoginViewModel>(context, listen: false).currentRole ==
        UserRole.admin;

    return Scaffold(
      appBar: AppBar(title: const Text('Speisekarte')),
      body: ListView.builder(
        itemCount: viewModel.essenListe.length,
        itemBuilder: (context, index) {
          final essen = viewModel.essenListe[index];
          if (isAdmin) {
            // Admins dürfen löschen
            return Dismissible(
              key: Key(essen.name + index.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                _einEssenLoeschen(essen);
              },
              confirmDismiss: (direction) async {
                return await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Bestätigung'),
                      content: Text(
                        'Möchten Sie "${essen.name}" wirklich löschen?',
                      ),
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
                title: Text(essen.name),
                subtitle: Text(essen.art.anzeigeName),
                trailing: Text('${essen.preis.toStringAsFixed(2)} €'),
                
                onTap: () {
                  _einEssenBearbeiten(essen, index);
                },
              ),
            );
          } else {
            // Nur lesender Zugriff für Nicht-Admins
            return ListTile(
              title: Text(essen.name),
              subtitle: Text(essen.art.anzeigeName),
              trailing: Text('${essen.preis.toStringAsFixed(2)} €'),
              
            );
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
