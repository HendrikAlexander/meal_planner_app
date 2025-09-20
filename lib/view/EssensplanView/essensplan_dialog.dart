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

  final _filterController = TextEditingController();

  @override
  void initState() {
    super.initState();
   
  _filterController.addListener(() => setState(() {}));
   
  }

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

 

  void _einenNeuenPlanHinzufuegen() async {
    final viewModel = Provider.of<EssensplanViewModel>(context, listen: false);
    final neuerPlan = await showDialog<Essensplan>(
      context: context,
      builder: (context) => const AddEssensplanDialog(),
    );
    if (neuerPlan != null) {
      viewModel.addEssensplan(neuerPlan);
      
    }
  }

  void _einenPlanBearbeiten(Essensplan alterPlan) async {
    final viewModel = Provider.of<EssensplanViewModel>(context, listen: false);
    
    final originalIndex = viewModel.wochenplaene.indexOf(alterPlan);

    final geaenderterPlan = await showDialog<Essensplan>(
      context: context,
      builder: (context) => AddEssensplanDialog(plan: alterPlan),
    );
    if (geaenderterPlan != null) {
      viewModel.updateEssensplan(originalIndex, geaenderterPlan);
      
    }
  }

 void _einenPlanLoeschen(Essensplan plan) {
  Provider.of<EssensplanViewModel>(context, listen: false)
  .deleteEssensplan(plan);
   
  }

  @override
  Widget build(BuildContext context) {
    final essensplanVM = context.watch<EssensplanViewModel>();
    final loginVM = context.read<LoginViewModel>(); 
    final isAdmin = loginVM.loggedInUser?.role == UserRole.admin;
    final l10n = AppLocalizations.of(context)!;

    
    final query = _filterController.text;
    final gefiltertePlaene = essensplanVM.wochenplaene.where((plan) {
      return plan.wochennummer.toString().contains(query);
    }).toList();
    
    
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
              itemCount: gefiltertePlaene.length, 
              itemBuilder: (context, index) {
                final plan = gefiltertePlaene[index]; 

                
                final tileContent = ExpansionTile(
                  title: Text(
                    '${l10n.week} ${plan.wochennummer}',
                    
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  
                  children: [
                    ...List.generate(plan.essenProWoche.length, (essenIndex) {
                      final essen = plan.essenProWoche[essenIndex];
                      
                      final wochentagKey = wochentageKeys[essenIndex];

                      final translatedName = getTranslatedMealName(essen.mealKey, l10n, essen: essen);
                      final translatedArt = getTranslatedArtName(essen.art, l10n);
                      final translatedWeekday = l10n.translate(wochentagKey); 

                      return ListTile(
                        title: Text('$translatedWeekday: $translatedName'),
                        
                        subtitle: Text(
                          '$translatedArt – ${essen.preis.toStringAsFixed(2)} €',
                          
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.rate_review_outlined),
                          tooltip: l10n.addReviewTooltip,
                          onPressed: () {
                            
                            showDialog(
                              context: context,
                              builder: (context) => AddBewertungDialog(essen: essen),
                            );
                          },
                        ),
                      );
                    }),
                    
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
                  
                  return Dismissible(
                    key: ValueKey(plan.wochennummer),
                    
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) => _einenPlanLoeschen(plan),
                   
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

String getTranslatedArtName(EssensArt art, AppLocalizations l10n) {
  switch (art) {
    case EssensArt.vegetarisch: return l10n.vegetarian;
    case EssensArt.vegan: return l10n.vegan;
    case EssensArt.mitFleisch: return l10n.withMeat;
  }
}