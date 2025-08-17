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

  // GEÄNDERT: Die Logik zum Bearbeiten wurde vereinfacht.
  void _gerichtBearbeiten(Essen altesEssen) async {
    // Merken uns den alten Namen, falls er sich ändert.
    final alterName = altesEssen.name;
    final warAusgewaehlt = _ausgewaehlteEssensNamen.contains(alterName);

    // Wir rufen den Bearbeiten-Dialog auf. Er verändert das "altesEssen"-Objekt direkt.
    await showDialog<Essen>(
      context: context,
      builder: (context) => AddEssenDialog(essen: altesEssen),
    );

    // Jetzt aktualisieren wir nur noch unsere lokale Anzeige und die Auswahlliste.
    setState(() {
      if (warAusgewaehlt) {
        // Wenn der Name geändert wurde, müssen wir unsere Auswahlliste anpassen.
        _ausgewaehlteEssensNamen.remove(alterName);
        _ausgewaehlteEssensNamen.add(altesEssen.name);
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
                        if (_ausgewaehlteEssensNamen.length < 5) {
                          _ausgewaehlteEssensNamen.add(essen.name);
                        }
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