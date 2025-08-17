import 'dart:io'; // Für File und Plattformabfrage (Android/iOS)
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Plattformcheck (Web)
import 'package:image_picker/image_picker.dart'; // Für Kamera
import 'package:provider/provider.dart';

import '../../model/essensbewertung.dart';
import '../../model/essen.dart'; // Damit der Dialog weiß, welches Essen bewertet wird
import '../../viewmodel/EssensbewertungViewModel/essensbewertung_viewmodel.dart';
import '../../viewmodel/LoginViewModel/login_viewmodel.dart';

/// Dialog zum Abgeben oder Bearbeiten einer Essensbewertung
class AddBewertungDialog extends StatefulWidget {
  /// Falls vorhanden, wird diese Bewertung bearbeitet
  final Essensbewertung? vorhandeneBewertung;

  // Das Essen, das bewertet wird
  final Essen? essen; // Ziel-Essen für diese Bewertung

  const AddBewertungDialog({super.key, this.vorhandeneBewertung, this.essen});

  @override
  State<AddBewertungDialog> createState() => _AddBewertungDialogState();
}

class _AddBewertungDialogState extends State<AddBewertungDialog> {
  final TextEditingController _textController = TextEditingController();   // Bewertungstext
  int _selectedRating = 3;                                                 // 1–5 Stern
  File? _imageFile; // Bild-Datei (nur Mobile)

  // Nur echte Mobile-Plattformen: Android/iOS (kein Web, kein Desktop)
  bool get _isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  void initState() {
    super.initState();
    // Wenn eine vorhandene Bewertung übergeben wurde → Felder vorausfüllen
    if (widget.vorhandeneBewertung != null) {
      _selectedRating = widget.vorhandeneBewertung!.essensbewertung;
      _textController.text = widget.vorhandeneBewertung!.essensbewertungstext;
      if (widget.vorhandeneBewertung!.essensfoto.isNotEmpty && _isMobile) {
        // Pfad ist nur auf Mobile sinnvoll (auf Web gibt es keinen lokalen File-Pfad)
        _imageFile = File(widget.vorhandeneBewertung!.essensfoto);
      }
    }
  }

  // Öffnet die Kamera und speichert das aufgenommene Bild (nur Mobile)
  Future<void> _bildAufnehmen() async {
    if (!_isMobile) {
      // Sicherheitsnetz: auf Web/Desktop gar nicht aktiv
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fotoaufnahme ist nur auf mobilen Geräten verfügbar.')),
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
      // Simulator hat meist keine Kamera → Hinweis
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kamera im Simulator nicht verfügbar. Bitte auf einem echten Gerät testen.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Eingeloggter Nutzer 
    final loginVM = context.watch<LoginViewModel>();
    final loggedInUser = loginVM.loggedInUser!; // bewusst non-null

    return AlertDialog(
      // Titel je nach Modus: Neu oder Bearbeiten
      title: Text(widget.vorhandeneBewertung == null
          ? 'Bewertung abgeben'
          : 'Bewertung bearbeiten'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Infozeile: Wer bewertet (aus dem Login, nicht editierbar)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Eingeloggt als: ${loggedInUser.username}',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(height: 12),

          // Dropdown zur Auswahl der Stern-Bewertung (1–5)
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

          // Textfeld für den Freitext der Bewertung (Pflicht)
          TextField(
            controller: _textController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Deine Bewertung',
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
            // Hinweis für Web/Desktop (kein Upload, kein FilePicker)
            const Text(
              'Fotoaufnahme ist nur auf mobilen Geräten (Android/iOS) verfügbar.',
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
            // Pflicht-Validierung: Bewertungstext darf nicht leer sein
            if (_textController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bitte geben Sie einen Bewertungstext ein.'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            // Neue Bewertung erstellen (Autorname kommt aus dem Login)
            final neueBewertung = Essensbewertung(
              essenName: widget.essen?.name ?? widget.vorhandeneBewertung!.essenName, // Essen-Name
              essensfoto: _isMobile ? (_imageFile?.path ?? '') : '', // Nur Mobile speichert Pfad
              essensbewertung: _selectedRating,
              essensbewertungstext: _textController.text,
              erstelltVon: loggedInUser.username, // 👤 automatisch aus Login
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
