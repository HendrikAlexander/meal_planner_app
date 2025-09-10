import 'package:flutter/material.dart';
import 'package:meal_planner_app/l10n/app_localizations.dart';
import 'package:meal_planner_app/model/user.dart';
import 'package:provider/provider.dart';
import '../../model/essen.dart';
import '../../model/essens_datenbank.dart';
import '../../viewmodel/SpeisekarteViewModel/essen_viewmodel.dart';
import 'add_essen_dialog.dart';

// WICHTIG: Imports für die Übersetzungen und das LoginViewModel

import '../../viewmodel/LoginViewModel/login_viewmodel.dart';

class EssenDialog extends StatelessWidget {
  const EssenDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // --- TEIL 1: DATEN HOLEN ---
    // Alle benötigten Daten werden am Anfang der build-Methode geholt.
    final essenVM = context.watch<EssenViewModel>();
    final loginVM = context.read<LoginViewModel>();
    final isAdmin = loginVM.loggedInUser?.role == UserRole.admin;
    final l10n = AppLocalizations.of(context)!;

    // --- TEIL 2: METHODEN DEFINIEREN (INNERHALB von build) ---
    // Die Methoden werden hier deklariert, damit sie auf die Variablen
    // aus Teil 1 (z.B. essenVM, context) zugreifen können.
    void _einNeuesEssenHinzufuegen() async {
      final neuesEssen = await showDialog<Essen>(
        context: context,
        builder: (BuildContext context) => const AddEssenDialog(),
      );
      if (neuesEssen != null) {
        essenVM.addEssen(neuesEssen);
      }
    }

    void _einEssenBearbeiten(Essen altesEssen, int index) async {
      final result = await showDialog(
        context: context,
        builder: (BuildContext context) => AddEssenDialog(essen: altesEssen),
      );
      if (result == null) return;
      if (result == 'DELETE_ACTION') {
        essenVM.deleteEssen(altesEssen);
      } else if (result is Essen) {
        essenVM.updateEssen(index, result);
      }
    }

    // --- TEIL 3: UI ZURÜCKGEBEN ---
    // Das ist der sichtbare Teil, der die Methoden aus Teil 2 verwendet.
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.speisekarteTitle),
      ),
      body: ListView.builder(
        itemCount: essenVM.essenListe.length,
        itemBuilder: (context, index) {
          final essen = essenVM.essenListe[index];
          final translatedName = getTranslatedMealName(essen.mealKey, l10n);
          final translatedArt = getTranslatedArtName(essen.art, l10n);

          final tile = ListTile(
            title: Text(translatedName),
            subtitle: Text(translatedArt),
            trailing: Text('${essen.preis.toStringAsFixed(2)} €'),
            onTap: isAdmin ? () => _einEssenBearbeiten(essen, index) : null,
          );

          if (isAdmin) {
            return Dismissible(
              key: ValueKey(essen.mealKey),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                essenVM.deleteEssen(essen);
              },
              confirmDismiss: (direction) async {
                return await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(l10n.confirmDeleteTitle),
                      content: Text(
                        l10n.confirmDeleteMealContent(translatedName),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(l10n.cancelButton),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(l10n.deleteButton),
                        ),
                      ],
                    );
                  },
                );
              },
              child: tile,
            );
          } else {
            return tile;
          }
        },
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: _einNeuesEssenHinzufuegen,
              tooltip: l10n.addMealTooltip,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

