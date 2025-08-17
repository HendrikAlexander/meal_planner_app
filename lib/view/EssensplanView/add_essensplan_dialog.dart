// lib/view/EssensplanView/add_essensplan_dialog.dart

import 'package:flutter/material.dart';
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
  final Set<String> _ausgewaehlteEssensNamen = {};

  @override
  void initState() {
    super.initState();
    if (widget.plan != null) {
      _wochennummerController.text = widget.plan!.wochennummer.toString();
      _ausgewaehlteEssensNamen.addAll(widget.plan!.essenProWoche.map((e) => e.name));
    }
  }

  // MODIFIED: This function now handles the "DELETE" signal
  void _gerichtBearbeiten(Essen altesEssen) async {
    final alterName = altesEssen.name;
    final warAusgewaehlt = _ausgewaehlteEssensNamen.contains(alterName);

    final result = await showDialog( // result can be Essen, String, or null
      context: context,
      builder: (context) => AddEssenDialog(essen: altesEssen),
    );

    if (result == null) return;

    setState(() {
      if (result == 'DELETE_ACTION') {
        _ausgewaehlteEssensNamen.remove(altesEssen.name);
        _datenbank.deleteEssen(altesEssen);
      } else if (result is Essen) {
        if (warAusgewaehlt) {
          _ausgewaehlteEssensNamen.remove(alterName);
          _ausgewaehlteEssensNamen.add(result.name);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.plan == null ? 'Neuen Wochenplan erstellen' : 'Wochenplan bearbeiten'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: [
            TextField(
              controller: _wochennummerController,
              decoration: const InputDecoration(labelText: 'Wochennummer'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Text('Wählen Sie genau 5 Gerichte aus (${_ausgewaehlteEssensNamen.length}/5):'),
            ..._datenbank.alleEssen.map((essen) {
              return ListTile(
                title: Text(essen.name),
                leading: Checkbox(
                  value: _ausgewaehlteEssensNamen.contains(essen.name),
                  onChanged: (bool? isChecked) {
                    setState(() {
                      if (isChecked == true) {
                        if (_ausgewaehlteEssensNamen.length < 5) { _ausgewaehlteEssensNamen.add(essen.name); }
                      } else {
                        _ausgewaehlteEssensNamen.remove(essen.name);
                      }
                    });
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () => _gerichtBearbeiten(essen),
                ),
              );
            }),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Abbrechen')),
        ElevatedButton(
          onPressed: () {
            if (_ausgewaehlteEssensNamen.length != 5) { return; }
            final List<Essen> finaleAuswahl = _datenbank.alleEssen
                .where((essen) => _ausgewaehlteEssensNamen.contains(essen.name))
                .toList();
            final neuerPlan = Essensplan(
              wochennummer: int.tryParse(_wochennummerController.text) ?? 0,
              essenProWoche: finaleAuswahl,
            );
            Navigator.of(context).pop(neuerPlan);
          },
          child: const Text('Speichern'),
        ),
      ],
    );
  }
}