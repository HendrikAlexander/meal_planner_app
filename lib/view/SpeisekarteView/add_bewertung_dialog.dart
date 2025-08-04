import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/essensbewertung.dart';
import '../../viewmodel/essensbewertung_viewmodel.dart';

/// Dialog zum Abgeben oder Bearbeiten einer Essensbewertung
class AddBewertungDialog extends StatefulWidget {
  /// Falls vorhanden, wird diese Bewertung bearbeitet
  final Essensbewertung? vorhandeneBewertung;

  const AddBewertungDialog({super.key, this.vorhandeneBewertung});

  @override
  State<AddBewertungDialog> createState() => _AddBewertungDialogState();
}

class _AddBewertungDialogState extends State<AddBewertungDialog> {
  final TextEditingController _textController = TextEditingController();
  int _selectedRating = 3;

  @override
  void initState() {
    super.initState();
    // Wenn eine vorhandene Bewertung übergeben wurde → Felder vorausfüllen
    if (widget.vorhandeneBewertung != null) {
      _selectedRating = widget.vorhandeneBewertung!.essensbewertung;
      _textController.text = widget.vorhandeneBewertung!.essensbewertungstext;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Titel je nach Modus: Neu oder Bearbeiten
      title: Text(widget.vorhandeneBewertung == null
          ? 'Bewertung abgeben'
          : 'Bewertung bearbeiten'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Dropdown zur Auswahl der Sternebewertung (1–5)
          DropdownButton<int>(
            value: _selectedRating,
            items: [1, 2, 3, 4, 5].map((wert) {
              return DropdownMenuItem(
                value: wert,
                child: Text('$wert Sterne'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedRating = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          // Textfeld für den Freitext der Bewertung
          TextField(
            controller: _textController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Deine Bewertung',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        // Button zum Schließen ohne Speichern
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Abbrechen'),
        ),
        // Button zum Speichern der Bewertung
        ElevatedButton(
          onPressed: () {
            // Neue Bewertung erstellen
            final neueBewertung = Essensbewertung(
              essensfoto: '', // Platzhalter – Foto kommt später
              essensbewertung: _selectedRating,
              essensbewertungstext: _textController.text,
            );

            if (widget.vorhandeneBewertung == null) {
              // ➕ Neue Bewertung → direkt in ViewModel speichern
              Provider.of<EssensbewertungViewModel>(context, listen: false)
                  .bewertungHinzufuegen(neueBewertung);
              Navigator.pop(context); // schließen ohne Rückgabe
            } else {
              // ✏️ Existierende Bewertung → Rückgabe an Aufrufer
              Navigator.pop(context, neueBewertung);
            }
          },
          child: const Text('Speichern'),
        ),
      ],
    );
  }
}
