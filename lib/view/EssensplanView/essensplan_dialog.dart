// lib/view/EssensplanView/essensplan_dialog.dart

import 'package:flutter/material.dart';
import 'package:meal_planner_app/model/user.dart';
import 'package:meal_planner_app/viewmodel/LoginViewModel/login_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../model/essens_art.dart';
import '../../model/essensplan.dart';
import '../../viewmodel/EssensplanViewModel/essensplan_viewmodel.dart';
import 'add_essensplan_dialog.dart';
import '../SpeisekarteView/add_bewertung_dialog.dart';

class EssensplanDialog extends StatefulWidget {
  const EssensplanDialog({super.key});

  @override
  State<EssensplanDialog> createState() => _EssensplanDialogState();
}

class _EssensplanDialogState extends State<EssensplanDialog> {
  final viewModel = EssensplanViewModel();
  late List<Essensplan> _allePlaene;
  List<Essensplan> _gefiltertePlaene = [];
  final _filterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _allePlaene = viewModel.wochenplaene;
    _gefiltertePlaene = _allePlaene;
    _filterController.addListener(_filterPlaene);
  }

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  void _filterPlaene() {
    final query = _filterController.text;
    setState(() {
      if (query.isEmpty) {
        _gefiltertePlaene = _allePlaene;
      } else {
        _gefiltertePlaene = _allePlaene.where((plan) {
          return plan.wochennummer.toString().contains(query);
        }).toList();
      }
    });
  }

  void _einenNeuenPlanHinzufuegen() async {
    final neuerPlan = await showDialog<Essensplan>(
      context: context,
      builder: (context) => const AddEssensplanDialog(),
    );
    if (neuerPlan != null) {
      viewModel.addEssensplan(neuerPlan);
      _filterPlaene(); // Filter neu anwenden
    }
  }

  void _einenPlanBearbeiten(Essensplan alterPlan) async {
    final originalIndex = _allePlaene.indexOf(alterPlan);
    final geaenderterPlan = await showDialog<Essensplan>(
      context: context,
      builder: (context) => AddEssensplanDialog(plan: alterPlan),
    );
    if (geaenderterPlan != null) {
      viewModel.updateEssensplan(originalIndex, geaenderterPlan);
      setState(() {
        _allePlaene = viewModel.wochenplaene;
      });
      _filterPlaene(); // Filter neu anwenden
    }
  }

  void _einenPlanLoeschen(Essensplan plan) {
    viewModel.deleteEssensplan(plan);
    _filterPlaene(); // Filter neu anwenden
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = Provider.of<LoginViewModel>(context, listen: false).currentRole == UserRole.admin;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wochenpläne'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _filterController,
              decoration: const InputDecoration(
                labelText: 'Nach Woche filtern...',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _gefiltertePlaene.length,
              itemBuilder: (context, index) {
                final plan = _gefiltertePlaene[index];

                if (isAdmin) {
    // Admins dürfen löschen
    return Dismissible(
      key: Key(plan.wochennummer.toString() + plan.essenProWoche.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        _einenPlanLoeschen(plan);
      },
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Bestätigung'),
              content: Text('Möchten Sie den Plan für Woche ${plan.wochennummer} wirklich löschen?'),
              actions: <Widget>[
                TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Abbrechen')),
                TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Löschen')),
              ],
            );
          },
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ExpansionTile(
          title: Text(
            'Woche ${plan.wochennummer}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            ...plan.essenProWoche.map((essen) => ListTile(
              title: Text(essen.name),
              subtitle: Text(
                '${essen.art.anzeigeName} – ${essen.preis.toStringAsFixed(2)} €',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.rate_review),
                tooltip: 'Bewertung abgeben',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddBewertungDialog(
                      essen: essen,
                    ),
                  );
                },
              ),
            )),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => _einenPlanBearbeiten(plan),
                icon: const Icon(Icons.edit),
                label: const Text('Plan bearbeiten'),
              ),
            ),
          ],
        ),
      ),
    );
  } else {
    // Nur lesender Zugriff für Nicht-Admins
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(
          'Woche ${plan.wochennummer}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          ...plan.essenProWoche.map((essen) => ListTile(
            title: Text(essen.name),
            subtitle: Text(
              '${essen.art.anzeigeName} – ${essen.preis.toStringAsFixed(2)} €',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.rate_review),
              tooltip: 'Bewertung abgeben',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AddBewertungDialog(
                    essen: essen,
                  ),
                );
              },
            ),
          )),
        ],
      ),
    );
  }
},
            ),
          ),
        ],
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: _einenNeuenPlanHinzufuegen,
              tooltip: 'Wochenplan hinzufügen',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
