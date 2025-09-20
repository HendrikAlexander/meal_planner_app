import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb; 
import 'package:image_picker/image_picker.dart'; 
import 'package:meal_planner_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../model/essensbewertung.dart';
import '../../model/essen.dart'; 
import '../../viewmodel/EssensbewertungViewModel/essensbewertung_viewmodel.dart';
import '../../viewmodel/LoginViewModel/login_viewmodel.dart';


class AddBewertungDialog extends StatefulWidget {
  
  final Essensbewertung? vorhandeneBewertung;

  
  final Essen? essen; 

  const AddBewertungDialog({super.key, this.vorhandeneBewertung, this.essen});

  @override
  State<AddBewertungDialog> createState() => _AddBewertungDialogState();
}

class _AddBewertungDialogState extends State<AddBewertungDialog> {
  final TextEditingController _textController = TextEditingController();   
  int _selectedRating = 3;                                                 
  File? _imageFile; 

  
  bool get _isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  bool get isEditing => widget.vorhandeneBewertung != null;

  @override
  void initState() {
    super.initState();
    
    if (isEditing) { 
      _selectedRating = widget.vorhandeneBewertung!.essensbewertung;
      _textController.text = widget.vorhandeneBewertung!.essensbewertungstext;
      if (widget.vorhandeneBewertung!.essensfoto.isNotEmpty && _isMobile) {
        
        _imageFile = File(widget.vorhandeneBewertung!.essensfoto);
      }
    }
  }

  
  Future<void> _bildAufnehmen(AppLocalizations l10n) async {
    if (!_isMobile) {
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(l10n.photoOnlyOnMobile)),
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
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(l10n.cameraNotAvailable)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final loginVM = context.watch<LoginViewModel>();
    final loggedInUser = loginVM.loggedInUser!; 
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      
      title: Text(isEditing ? l10n.editReviewTitle : l10n.addReviewTitle), 
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              l10n.loggedInAs(loggedInUser.username), 
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(height: 12),

          
          DropdownButton<int>(
            value: _selectedRating,
            items: [1, 2, 3, 4, 5].map((wert) {
              return DropdownMenuItem(
                value: wert,
                child: Text(l10n.starsRating(wert.toString())), 
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedRating = value!;
              });
            },
          ),
          const SizedBox(height: 16),

          
          TextField(
            controller: _textController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: l10n.yourReviewLabel,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          
          if (_isMobile) ...[
            ElevatedButton.icon(
              onPressed: () => _bildAufnehmen(l10n), 
              icon: const Icon(Icons.camera_alt),
              label: Text(l10n.takeAPhoto),
            ),
            if (_imageFile != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.file(_imageFile!, height: 100),
              ),
          ] else ...[
            
             Text(
              l10n.photoOnlyOnMobile,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ],
      ),
      actions: [
        
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancelButton),
        ),

        
        ElevatedButton(
          onPressed: () {
            
            if (_textController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.reviewTextRequired),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }
             final mealKey = widget.essen?.mealKey ?? widget.vorhandeneBewertung!.essenMealKey;

            
            final neueBewertung = Essensbewertung(
              essenMealKey: mealKey,
             
              essensfoto: _isMobile ? (_imageFile?.path ?? '') : '', 
              essensbewertung: _selectedRating,
              essensbewertungstext: _textController.text,
              erstelltVon: loggedInUser.username, 
            );

            if (!isEditing) { 
              
              Provider.of<EssensbewertungViewModel>(context, listen: false)
                  .bewertungHinzufuegen(neueBewertung);
              Navigator.pop(context); 
            } else {
              
              Navigator.pop(context, neueBewertung);
            }
          },
          child: Text(l10n.saveButton),
        ),
      ],
    );
  }
}
