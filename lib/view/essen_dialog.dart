import 'package:flutter/material.dart';


import '../viewmodel/essen_viewmodel.dart';


// Dies ist unsere UI-Komponente, ein "Widget".
class EssenDialog extends StatelessWidget {
  // Der Konstruktor für das Widget.
  EssenDialog({super.key});

  // Hier erstellen wir eine Instanz unseres ViewModels.
  // Die View "stellt also ihren Kellner ein".
  final EssenViewModel viewModel = EssenViewModel();

  @override
  Widget build(BuildContext context) {
    // Scaffold ist das Grundgerüst für eine Standard-App-Seite.
    return Scaffold(
      // Die obere Leiste der App.
      appBar: AppBar(
        title: const Text('Speisekarte'),
      ),
      // Der Körper der Seite.
      // ListView.builder ist perfekt, um lange Listen effizient anzuzeigen.
      body: ListView.builder(
        // Wir sagen der Liste, wie viele Einträge sie anzeigen soll.
        itemCount: viewModel.essenListe.length,
        // Diese Funktion wird für jeden einzelnen Eintrag in der Liste aufgerufen.
        itemBuilder: (context, index) {
          // Wir holen uns das aktuelle Essen-Objekt aus der Liste des ViewModels.
          final essen = viewModel.essenListe[index];
          // ListTile ist ein vorgefertigtes Widget für einen Listeneintrag.
          return ListTile(
            title: Text(essen.name),
            subtitle: Text(essen.art),
            // toStringAsFixed(2) sorgt für eine saubere Anzeige mit 2 Nachkommastellen.
            trailing: Text('${essen.preis.toStringAsFixed(2)} €'),
          );
        },
      ),
    );
  }
}