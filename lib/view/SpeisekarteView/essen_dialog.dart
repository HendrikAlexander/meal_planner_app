// lib/view/essen_dialog.dart

import 'package:flutter/material.dart';
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
        // Ruft den Dialog im "Erstellen"-Modus auf (ohne Essen-Objekt)
        return const AddEssenDialog();
      },
    );
    if (neuesEssen != null) {
      setState(() {
        viewModel.addEssen(neuesEssen);
      });
    }
  }

  // NEUE FUNKTION: Öffnet den Dialog zum Bearbeiten eines Essens
  void _einEssenBearbeiten(Essen altesEssen, int index) async {
    final geaendertesEssen = await showDialog<Essen>(
      context: context,
      builder: (BuildContext context) {
        // Ruft den Dialog im "Bearbeiten"-Modus auf und übergibt das vorhandene Essen
        return AddEssenDialog(essen: altesEssen);
      },
    );
    if (geaendertesEssen != null) {
      setState(() {
        viewModel.updateEssen(index, geaendertesEssen);
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
                    content: Text('Möchten Sie "${essen.name}" wirklich löschen?'),
                    actions: <Widget>[
                      TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Abbrechen')),
                      TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Löschen')),
                    ],
                  );
                },
              );
            },
            child: ListTile(
              title: Text(essen.name),
              subtitle: Text(essen.art.anzeigeName),
              trailing: Text('${essen.preis.toStringAsFixed(2)} €'),
              // NEU: Fügt die "Tippen"-Aktion hinzu
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