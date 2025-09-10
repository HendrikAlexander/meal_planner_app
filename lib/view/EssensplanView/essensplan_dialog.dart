// lib/view/EssensplanView/essensplan_dialog.dart

import 'package:flutter/material.dart';
import 'package:meal_planner_app/l10n/app_localizations.dart';
import 'package:meal_planner_app/model/essens_datenbank.dart';
import 'package:meal_planner_app/model/user.dart';
import 'package:meal_planner_app/viewmodel/LoginViewModel/login_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../model/essens_art.dart';
import '../../model/essensplan.dart';
import '../../viewmodel/EssensplanViewModel/essensplan_viewmodel.dart';
import 'add_essensplan_dialog.dart';
import '../EssensbewertungView/add_bewertung_dialog.dart';

class EssensplanDialog extends StatefulWidget {
  const EssensplanDialog({super.key});

  @override
  State<EssensplanDialog> createState() => _EssensplanDialogState();
}

class _EssensplanDialogState extends State<EssensplanDialog> {
// final viewModel = EssensplanViewModel();
//late List<Essensplan> _allePlaene;
//  List<Essensplan> _gefiltertePlaene = [];
  final _filterController = TextEditingController();

  @override
  void initState() {
    super.initState();
   // _allePlaene = viewModel.wochenplaene;
   // _gefiltertePlaene = _allePlaene;
  _filterController.addListener(() => setState(() {}));
   // _filterController.addListener(_filterPlaene);
  }

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  //void _filterPlaene() {
  //  final query = _filterController.text;
   // setState(() {
   //   if (query.isEmpty) {
   //     _gefiltertePlaene = _allePlaene;
   //   } else {
    //    _gefiltertePlaene = _allePlaene.where((plan) {
    //      return plan.wochennummer.toString().contains(query);
    //    }).toList();
    //  }
   // });
// }

  void _einenNeuenPlanHinzufuegen() async {
    final viewModel = Provider.of<EssensplanViewModel>(context, listen: false);
    final neuerPlan = await showDialog<Essensplan>(
      context: context,
      builder: (context) => const AddEssensplanDialog(),
    );
    if (neuerPlan != null) {
      viewModel.addEssensplan(neuerPlan);
      //_filterPlaene(); // Filter neu anwenden
    }
  }

  void _einenPlanBearbeiten(Essensplan alterPlan) async {
    final viewModel = Provider.of<EssensplanViewModel>(context, listen: false);
    // final originalIndex = _allePlaene.indexOf(alterPlan);
    final originalIndex = viewModel.wochenplaene.indexOf(alterPlan);

    final geaenderterPlan = await showDialog<Essensplan>(
      context: context,
      builder: (context) => AddEssensplanDialog(plan: alterPlan),
    );
    if (geaenderterPlan != null) {
      viewModel.updateEssensplan(originalIndex, geaenderterPlan);
      // HINWEIS: Die setState-Zeile hier war überflüssig und wurde entfernt,
      // da _filterPlaene() bereits setState aufruft.
      // _filterPlaene(); // Filter neu anwenden
    }
  }

 void _einenPlanLoeschen(Essensplan plan) {
  Provider.of<EssensplanViewModel>(context, listen: false)
  .deleteEssensplan(plan);
   // setState(() {
   //   viewModel.deleteEssensplan(plan);
   //   _filterPlaene(); 
   // });
  }

  @override
  Widget build(BuildContext context) {
    final essensplanVM = context.watch<EssensplanViewModel>();
    // final loginVM = Provider.of<LoginViewModel>(context, listen: false);
    final loginVM = context.read<LoginViewModel>(); // "read" für einmaligen Zugriff
    final isAdmin = loginVM.loggedInUser?.role == UserRole.admin;
    final l10n = AppLocalizations.of(context)!;

    // Die Filterlogik wird jetzt direkt hier im Build angewendet.
    final query = _filterController.text;
    final gefiltertePlaene = essensplanVM.wochenplaene.where((plan) {
      return plan.wochennummer.toString().contains(query);
    }).toList();
    
    // Eine Liste mit den Wochentagen für die Anzeige
    const wochentageKeys = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday'];

    return Scaffold(
      appBar: AppBar(
        title:  Text(l10n.essensplanTitle),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _filterController,
              decoration: InputDecoration(
                labelText: l10n.filterByWeek,
                suffixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: gefiltertePlaene.length, // _ weggenommen
              itemBuilder: (context, index) {
                final plan = gefiltertePlaene[index]; // _ weggenommen

                // Der Inhalt der Kachel, der für beide (Admin/User) gleich ist
                final tileContent = ExpansionTile(
                  title: Text(
                    '${l10n.week} ${plan.wochennummer}',
                    // 'Woche ${plan.wochennummer}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // KORRIGIERT: Wir bauen die Liste jetzt mit Index, um den Wochentag zuzuordnen
                  children: [
                    ...List.generate(plan.essenProWoche.length, (essenIndex) {
                      final essen = plan.essenProWoche[essenIndex];
                      // Wir stellen sicher, dass wir nicht mehr Wochentage als vorhanden zugreifen
                      //final wochentag = essenIndex < wochentage.length ? wochentage[essenIndex] : '';
                      final wochentagKey = wochentageKeys[essenIndex];

                      final translatedName = getTranslatedMealName(essen.mealKey, l10n);
                      final translatedArt = getTranslatedArtName(essen.art, l10n);
                      final translatedWeekday = l10n.translate(wochentagKey); 

                      return ListTile(
                        title: Text('$translatedWeekday: $translatedName'),
                        //Text('${wochentag}: ${essen.name}'),
                        subtitle: Text(
                          '$translatedArt – ${essen.preis.toStringAsFixed(2)} €',
                          // '${essen.art.localizedName} – ${essen.preis.toStringAsFixed(2)} €',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.rate_review_outlined),
                          tooltip: l10n.addReviewTooltip,
                          onPressed: () {
                            // Annahme: AddBewertungDialog benötigt ein `essen`-Objekt
                            showDialog(
                              context: context,
                              builder: (context) => AddBewertungDialog(essen: essen),
                            );
                          },
                        ),
                      );
                    }),
                    // Der "Bearbeiten"-Button wird nur für Admins innerhalb der ExpansionTile angezeigt
                    if (isAdmin)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () => _einenPlanBearbeiten(plan),
                          icon: const Icon(Icons.edit),
                          label: Text(l10n.editPlanButton),
                        ),
                      ),
                  ],
                );

                if (isAdmin) {
                  // Admins bekommen die Wisch-zum-Löschen-Funktion
                  return Dismissible(
                    key: ValueKey(plan.wochennummer),
                    // key: Key(plan.wochennummer.toString() + plan.essenProWoche.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) => _einenPlanLoeschen(plan),
                   // onDismissed: (direction) {
                   //   _einenPlanLoeschen(plan);
                   // },
                    confirmDismiss: (direction) async {
                      return await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:  Text(l10n.confirmDeleteTitle),
                            content: Text(l10n.confirmDeletePlanContent(plan.wochennummer.toString())),
                            actions: <Widget>[
                              TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.cancelButton)),
                              TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text(l10n.deleteButton)),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: tileContent,
                    ),
                  );
                } else {
                  // Normale User sehen nur die Kachel ohne Wisch-Funktion
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: tileContent,
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: _einenNeuenPlanHinzufuegen,
              tooltip: l10n.addPlanTooltip,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
// Kleine Helfer-Extension auf AppLocalizations, um Wochentage dynamisch zu übersetzen.
extension LocalizationHelper on AppLocalizations {
  String translate(String key) {
    switch (key) {
      case 'monday': return monday;
      case 'tuesday': return tuesday;
      case 'wednesday': return wednesday;
      case 'thursday': return thursday;
      case 'friday': return friday;
      default: return '';
    }
  }
}