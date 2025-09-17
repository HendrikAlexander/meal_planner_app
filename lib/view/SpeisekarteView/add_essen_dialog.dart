import 'package:flutter/material.dart';
import 'package:meal_planner_app/l10n/app_localizations.dart';
import '../../model/essen.dart';
import '../../model/essens_art.dart';
import '../../model/essens_datenbank.dart';

class AddEssenDialog extends StatefulWidget {
  final Essen? essen; // Kann ein bestehendes Essen zum Bearbeiten sein
  const AddEssenDialog({super.key, this.essen});

  @override
  State<AddEssenDialog> createState() => _AddEssenDialogState();
}

class _AddEssenDialogState extends State<AddEssenDialog> {
  final _formKey = GlobalKey<FormState>();
  // Wir verwenden Controller für die Textfelder
  final _nameController = TextEditingController();
  final _preisController = TextEditingController();
  late EssensArt _ausgewaehlteArt;

  // Bestimmt, ob wir im "Bearbeiten"-Modus sind
  bool get isEditing => widget.essen != null;

  @override
  void initState() {
    super.initState();

    // Wenn wir ein Essen bearbeiten, füllen wir die Felder mit den existierenden Daten.
    if (isEditing) { //widget.essen != null
    final essen = widget.essen!;
    _nameController.text = essen.name ?? '';
    _preisController.text = essen.preis.toString();
    _ausgewaehlteArt = essen.art;

          // WICHTIG: Wir müssen den Kontext abwarten, um auf l10n zuzugreifen.
      // `addPostFrameCallback` führt den Code aus, nachdem der erste Frame gezeichnet wurde.
    //  WidgetsBinding.instance.addPostFrameCallback((_) {
       // if (mounted) { // Sicherheitscheck, ob das Widget noch im Baum ist
        //  final l10n = AppLocalizations.of(context)!;
        // _nameController.text = getTranslatedMealName(widget.essen!.mealKey, l10n);
          // _nameController.text = widget.essen!.name;
   //))
     // _ausgewaehlteArt = widget.essen!.art;
    } else {
      // Wenn wir ein neues Essen erstellen, starten wir mit einem Standardwert.
      _ausgewaehlteArt = EssensArt.vegetarisch;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _preisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Hole die Übersetzungen
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(isEditing ? l10n.editMealTitle : l10n.addMealTitle), // widget.essen == null ? 'Neues Essen anlegen' : 'Essen bearbeiten'
      content: SingleChildScrollView( // Verhindert Pixel-Overflow auf kleinen Bildschirmen
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Im Bearbeiten-Modus kann der Name (mealKey) nicht geändert werden.
            // Wir zeigen ihn nur an.
           // if (isEditing)
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: l10n.mealNameLabel),
                autofocus: !isEditing,
                // readOnly: true, // Macht das Feld schreibgeschützt
              ),
           // else
              // Nur im "Neu anlegen"-Modus kann ein Name vergeben werden.
              TextField(
                controller: _preisController,
                decoration: InputDecoration(labelText: l10n.priceLabel),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                 // autofocus: true,
              ),
           // TextField(
             // controller: _preisController,
             // decoration: InputDecoration(labelText: l10n.priceLabel),
             // keyboardType: const TextInputType.numberWithOptions(decimal: true),
           // ),
            DropdownButton<EssensArt>(
              value: _ausgewaehlteArt,
              isExpanded: true,
              items: EssensArt.values.map((EssensArt art) {
                return DropdownMenuItem<EssensArt>(
                  value: art,
                  child: Text(getTranslatedArtName(art, l10n)), // art.localizedName(context)
                );
              }).toList(),
              onChanged: (EssensArt? neuerWert) {
                if (neuerWert != null) {
                  setState(() {
                    _ausgewaehlteArt = neuerWert;
                  });
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        // NEW: "Löschen" button, only visible in edit mode
        if (isEditing) // widget.essen != null
          TextButton(
            onPressed: () {
              // Closes the dialog and sends the "DELETE" signal
              Navigator.of(context).pop('DELETE_ACTION');
            },
            child: Text(l10n.deleteButton, style: const TextStyle(color: Colors.red)),
          ),
        const Spacer(),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancelButton),
        ),
        ElevatedButton(
          onPressed: () {
            // Konvertiert den Benutzernamen in einen gültigen Schlüssel (z.B. "Spaghetti Carbonara" -> "spaghettiCarbonara")
            final mealKey = isEditing
                ? widget.essen!.mealKey
                : _nameController.text.trim().replaceAll(' ', '').replaceFirstMapped(RegExp(r'.'), (m) => m.group(0)!.toLowerCase());

            // if (widget.essen != null) {
            //   widget.essen!.name = _nameController.text;
            //   widget.essen!.preis = double.tryParse(_preisController.text) ?? 0.0;
            //   widget.essen!.art = _ausgewaehlteArt;
            //   Navigator.of(context).pop(widget.essen);
            // } else {
            final neuesEssen = Essen(
              mealKey: mealKey, // name: _nameController.text,
              name: _nameController.text.trim(),
              preis: double.tryParse(_preisController.text.replaceAll(',', '.')) ?? 0.0, // preis: double.tryParse(_preisController.text) ?? 0.0,
              art: _ausgewaehlteArt,
            );
            // Schließt den Dialog und gibt das erstellte Objekt zurück.
            Navigator.of(context).pop(neuesEssen);
            // }
          },
          child: Text(l10n.saveButton),
        ),
      ],
    );
  }
}
