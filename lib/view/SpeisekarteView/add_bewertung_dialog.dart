import 'dart:io'; // Für File
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Plattformcheck (Web)
import 'package:image_picker/image_picker.dart'; // Für Kamera
import 'package:provider/provider.dart';
import '../../model/essensbewertung.dart';
import '../../viewmodel/essensbewertung_viewmodel.dart';
import '../../model/essen.dart'; 

/// Dialog zum Abgeben oder Bearbeiten einer Essensbewertung
class AddBewertungDialog extends StatefulWidget {
  /// Falls vorhanden, wird diese Bewertung bearbeitet
  final Essensbewertung? vorhandeneBewertung;

  // NEU: Das Essen, das bewertet wird
  final Essen? essen; // Das Ziel-Essen für diese Bewertung

  const AddBewertungDialog({super.key, this.vorhandeneBewertung, this.essen});

  @override
  State<AddBewertungDialog> createState() => _AddBewertungDialogState();
}

class _AddBewertungDialogState extends State<AddBewertungDialog> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _autorController = TextEditingController(); // Autor-Name Controller
  int _selectedRating = 3;
  File? _imageFile; // Bild-Datei (vom Nutzer aufgenommen)

  // Nur echte Mobile-Plattformen: Android/iOS (kein Web, kein Desktop)
  bool get _isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  void initState() {
    super.initState();
    // Wenn eine vorhandene Bewertung übergeben wurde → Felder vorausfüllen
    if (widget.vorhandeneBewertung != null) {
      _selectedRating = widget.vorhandeneBewertung!.essensbewertung;
      _textController.text = widget.vorhandeneBewertung!.essensbewertungstext;
      _autorController.text = widget.vorhandeneBewertung!.erstelltVon; // 👤 Autor vorausfüllen
      if (widget.vorhandeneBewertung!.essensfoto.isNotEmpty) {
        _imageFile = File(widget.vorhandeneBewertung!.essensfoto);
      }
    }
  }

  // Öffnet die Kamera und speichert das aufgenommene Bild
  Future<void> _bildAufnehmen() async {
    if (!_isMobile) {
      // Sicherheitsnetz: sollte nie sichtbar sein, aber falls doch:
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fotoaufnahme ist nur auf Mobile verfügbar.')),
        );
      }
      return;
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      // Simulator hat meist keine Kamera → deutlicher Hinweis
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kamera im Simulator nicht verfügbar. Bitte auf einem echten Gerät testen.')),
        );
      }
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
                child: Text('$wert Stern'),
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
          const SizedBox(height: 12),
          // Textfeld für den Namen/Ersteller
          TextField(
            controller: _autorController,
            decoration: const InputDecoration(
              labelText: 'Dein Name (Ersteller)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // Kamera-Button und Bild-Vorschau — NUR Mobile (Android/iOS)
          if (_isMobile) ...[
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
          ] else ...[
            // Hinweis für Web/Desktop
            const Text(
              'Fotoaufnahme ist nur auf Mobile (Android/iOS) verfügbar.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
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
              essenName: widget.essen?.name ?? widget.vorhandeneBewertung!.essenName, // Essen-Name
              essensfoto: _isMobile ? (_imageFile?.path ?? '') : '', // Nur Mobile speichert Pfad
              essensbewertung: _selectedRating,
              essensbewertungstext: _textController.text,
              erstelltVon: _autorController.text.trim(), // Autor speichern
            );

            if (widget.vorhandeneBewertung == null) {
              // Neue Bewertung → direkt in ViewModel speichern
              Provider.of<EssensbewertungViewModel>(context, listen: false)
                  .bewertungHinzufuegen(neueBewertung);
              Navigator.pop(context); // schließen ohne Rückgabe
            } else {
              // Existierende Bewertung → Rückgabe an Aufrufer
              Navigator.pop(context, neueBewertung);
            }
          },
          child: const Text('Speichern'),
        ),
      ],
    );
  }
}
