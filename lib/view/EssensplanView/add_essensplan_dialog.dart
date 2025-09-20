// lib/view/EssensplanView/add_essensplan_dialog.dart

import 'package:flutter/material.dart';
import 'package:meal_planner_app/l10n/app_localizations.dart';
import '../../model/essen.dart';
import '../../model/essens_datenbank.dart';
import '../../model/essensplan.dart';
import '../SpeisekarteView/add_essen_dialog.dart';

class AddEssensplanDialog extends StatefulWidget {
  final Essensplan? plan;
  const AddEssensplanDialog({super.key, this.plan});

  @override
  State<AddEssensplanDialog> createState() => _AddEssensplanDialogState();
}

class _AddEssensplanDialogState extends State<AddEssensplanDialog> {
  final _wochennummerController = TextEditingController();
  final Essensdatenbank _datenbank = Essensdatenbank.instance;
  
  final List<Essen> _ausgewaehlteEssen = [];
  bool get isEditing => widget.plan != null;


  @override
  void initState() {
    super.initState();
    if (isEditing) { 
      _wochennummerController.text = widget.plan!.wochennummer.toString();
      _ausgewaehlteEssen.addAll(widget.plan!.essenProWoche);
    }
  }
  @override
  void dispose() {
    _wochennummerController.dispose();
    super.dispose();
  }

  void _gerichtBearbeiten(Essen altesEssen) async {
    
    final result = await showDialog(
      context: context,
      builder: (context) => AddEssenDialog(essen: altesEssen),
    );

    
    if (result == null) return;

    
    setState(() {
      if (result == 'DELETE_ACTION') {
        
        _ausgewaehlteEssen.removeWhere((e) => e.mealKey == altesEssen.mealKey);
        
        _datenbank.deleteEssen(altesEssen);
      } else if (result is Essen) {
        
        final originalIndexInDb = _datenbank.speisekarte.indexWhere(
          (e) => e.mealKey == altesEssen.mealKey,
           );
        if (originalIndexInDb != -1) {
          _datenbank.updateEssen(originalIndexInDb, result);
        }
         final originalIndexInPlan = _ausgewaehlteEssen.indexWhere(
          (e) => e.mealKey == altesEssen.mealKey,
          );
          if (originalIndexInPlan != -1) {
          _ausgewaehlteEssen[originalIndexInPlan] = result;
          }
        }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final verfuegbareEssen = _datenbank.speisekarte
        .where((essen) => !_ausgewaehlteEssen.contains(essen))
        .toList();

    final wochentage = [l10n.monday, l10n.tuesday, l10n.wednesday, l10n.thursday, l10n.friday];

    return AlertDialog(
      title: Text(isEditing ? l10n.editPlanTitle : l10n.addPlanTitle), 
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _wochennummerController,
                decoration: InputDecoration(labelText: l10n.weekNumberLabel),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              Text(l10n.selectedMealsLabel(_ausgewaehlteEssen.length.toString()), style: const TextStyle(fontWeight: FontWeight.bold)),
              
              ReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final Essen item = _ausgewaehlteEssen.removeAt(oldIndex);
                    _ausgewaehlteEssen.insert(newIndex, item);
                  });
                },
                children: List.generate(_ausgewaehlteEssen.length, (index) {
                  final essen = _ausgewaehlteEssen[index];
                  final translatedName = getTranslatedMealName(essen.mealKey, l10n, essen: essen);
            
                  return ListTile(
                    key: ValueKey(essen.mealKey), 
                    leading: const Icon(Icons.drag_handle),
                    title: Text('${wochentage.length > index ? wochentage[index] : ''}: $translatedName'),
                    
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          tooltip: l10n.editMealTooltip,
                          onPressed: () => _gerichtBearbeiten(essen),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle, color: Colors.red),
                          tooltip: l10n.removeMealFromPlanTooltip,
                          onPressed: () {
                            setState(() {
                              _ausgewaehlteEssen.remove(essen);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }),
              ),

              const Divider(height: 30),
              Text(l10n.availableMealsLabel, style: const TextStyle(fontWeight: FontWeight.bold)),
              ...verfuegbareEssen.map((essen) {
                final translatedName = getTranslatedMealName(essen.mealKey, l10n, essen: essen);
                return ListTile(
                  title: Text(translatedName),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.green),
                    tooltip: l10n.addMealToPlanTooltip,
                    onPressed: () {
                      if (_ausgewaehlteEssen.length < 5) {
                        setState(() {
                          _ausgewaehlteEssen.add(essen);
                        });
                      }
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.cancelButton)),
        ElevatedButton(
          onPressed: () {
            if (_ausgewaehlteEssen.length != 5) { return; }
            final neuerPlan = Essensplan(
              wochennummer: int.tryParse(_wochennummerController.text) ?? 0,
              essenProWoche: _ausgewaehlteEssen,
            );
            Navigator.of(context).pop(neuerPlan);
          },
          child: Text(l10n.saveButton),
        ),
      ],
    );
  }
}