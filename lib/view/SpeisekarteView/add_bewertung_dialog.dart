import 'dart:io'; // Für File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Für Kamera
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
  File? _imageFile; // 📸 Bild-Datei (vom Nutzer aufgenommen)

  @override
  void initState() {
    super.initState();
    // Wenn eine vorhandene Bewertung übergeben wurde → Felder vorausfüllen
    if (widget.vorhandeneBewertung != null) {
      _selectedRating = widget.vorhandeneBewertung!.essensbewertung;
      _textController.text = widget.vorhandeneBewertung!.essensbewertungstext;
      if (widget.vorhandeneBewertung!.essensfoto.isNotEmpty) {
        _imageFile = File(widget.vorhandeneBewertung!.essensfoto);
      }
    }
  }

  // 📷 Öffnet die Kamera und speichert das aufgenommene Bild
  Future<void> _bildAufnehmen() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
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
          const SizedBox(height: 16),
          // 📸 Kamera-Button und Bild-Vorschau
          ElevatedButton.icon(
            onPressed: _bildAufnehmen,
            icon: const Icon(Icons.camera_alt),
            label: const Text("Foto aufnehmen"),
          ),
          if (_imageFile != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.file(_imageFile!, height: 100),
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
              essensfoto: _imageFile?.path ?? '', // ✅ Bildpfad speichern
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
