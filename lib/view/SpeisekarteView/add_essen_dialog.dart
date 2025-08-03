// lib/view/SpeisekarteView/add_essen_dialog.dart

import 'package:flutter/material.dart';
import '../../model/essen.dart';
import '../../model/essens_art.dart';

class AddEssenDialog extends StatefulWidget {
  final Essen? essen;
  const AddEssenDialog({super.key, this.essen});

  @override
  State<AddEssenDialog> createState() => _AddEssenDialogState();
}

class _AddEssenDialogState extends State<AddEssenDialog> {
  final _nameController = TextEditingController();
  final _preisController = TextEditingController();
  late EssensArt _ausgewaehlteArt;

  @override
  void initState() {
    super.initState();
    if (widget.essen != null) {
      _nameController.text = widget.essen!.name;
      _preisController.text = widget.essen!.preis.toString();
      _ausgewaehlteArt = widget.essen!.art;
    } else {
      _ausgewaehlteArt = EssensArt.vegetarisch;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.essen == null ? 'Neues Essen anlegen' : 'Essen bearbeiten'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name des Gerichts'),
            autofocus: true,
          ),
          TextField(
            controller: _preisController,
            decoration: const InputDecoration(labelText: 'Preis'),
            keyboardType: TextInputType.number,
          ),
          DropdownButton<EssensArt>(
            value: _ausgewaehlteArt,
            isExpanded: true,
            items: EssensArt.values.map((EssensArt art) {
              return DropdownMenuItem<EssensArt>(
                value: art,
                child: Text(art.anzeigeName),
              );
            }).toList(),
            onChanged: (EssensArt? neuerWert) {
              setState(() {
                _ausgewaehlteArt = neuerWert!;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Abbrechen'),
        ),
        ElevatedButton(
          onPressed: () {
            // GEÄNDERT: Die Logik zum Speichern wurde angepasst.
            if (widget.essen != null) {
              // Bearbeiten-Modus: Wir verändern das bestehende Objekt.
              widget.essen!.name = _nameController.text;
              widget.essen!.preis = double.tryParse(_preisController.text) ?? 0.0;
              widget.essen!.art = _ausgewaehlteArt;
              Navigator.of(context).pop(widget.essen);
            } else {
              // Erstellen-Modus: Wir erstellen ein neues Objekt.
              final neuesEssen = Essen(
                name: _nameController.text,
                preis: double.tryParse(_preisController.text) ?? 0.0,
                art: _ausgewaehlteArt,
              );
              Navigator.of(context).pop(neuesEssen);
            }
          },
          child: const Text('Speichern'),
        ),
      ],
    );
  }
}