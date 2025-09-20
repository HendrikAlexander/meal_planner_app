import 'package:flutter/material.dart';
import 'package:meal_planner_app/l10n/app_localizations.dart';
import '../../model/essen.dart';
import '../../model/essens_art.dart';

class AddEssenDialog extends StatefulWidget {
  final Essen? essen; 
  const AddEssenDialog({super.key, this.essen});

  @override
  State<AddEssenDialog> createState() => _AddEssenDialogState();
}

class _AddEssenDialogState extends State<AddEssenDialog> {
  
  final _nameDeController = TextEditingController();
  final _nameEnController = TextEditingController();
  final _preisController = TextEditingController();
  late EssensArt _ausgewaehlteArt;

  
  bool get isEditing => widget.essen != null;

  @override
  void initState() {
    super.initState();

    
    if (isEditing) {
      final essen = widget.essen!;
      _nameDeController.text = essen.nameDe ?? '';
      _nameEnController.text = essen.nameEn ?? '';
      _preisController.text = essen.preis.toString();
      _ausgewaehlteArt = essen.art;
    } else {
      
      _ausgewaehlteArt = EssensArt.vegetarisch;
    }
  }

  @override
  void dispose() {
    _nameDeController.dispose();
    _nameEnController.dispose();
    _preisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(isEditing ? l10n.editMealTitle : l10n.addMealTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            TextField(
              controller: _nameDeController,
              decoration: InputDecoration(labelText: '${l10n.mealNameLabel} (DE)'),
              autofocus: !isEditing,
            ),
            TextField(
              controller: _nameEnController,
              decoration: InputDecoration(labelText: '${l10n.mealNameLabel} (EN)'),
            ),
            TextField(
              controller: _preisController,
              decoration: InputDecoration(labelText: l10n.priceLabel),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            DropdownButton<EssensArt>(
              value: _ausgewaehlteArt,
              isExpanded: true,
              items: EssensArt.values.map((EssensArt art) {
                return DropdownMenuItem<EssensArt>(
                  value: art,
                  child: Text(getTranslatedArtName(art, l10n)),
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
        if (isEditing)
          TextButton(
            onPressed: () {
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
            final mealKey = isEditing
                ? widget.essen!.mealKey
                : _nameDeController.text.trim().replaceAll(' ', '').replaceFirstMapped(RegExp(r'.'), (m) => m.group(0)!.toLowerCase());

            final neuesEssen = Essen(
              mealKey: mealKey,
              nameDe: _nameDeController.text.trim(),
              nameEn: _nameEnController.text.trim(),
              preis: double.tryParse(_preisController.text.replaceAll(',', '.')) ?? 0.0,
              art: _ausgewaehlteArt,
            );
            Navigator.of(context).pop(neuesEssen);
          },
          child: Text(l10n.saveButton),
        ),
      ],
    );
  }
}


String getTranslatedArtName(EssensArt art, AppLocalizations l10n) {
  switch (art) {
    case EssensArt.vegetarisch: return l10n.vegetarian;
    case EssensArt.vegan: return l10n.vegan;
    case EssensArt.mitFleisch: return l10n.withMeat;
  }
}
