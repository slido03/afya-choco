import 'package:afya/src/model/models.dart';
import 'package:afya/src/viewModel/evenement_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
//import 'package:flutter/foundation.dart';
//import 'package:intl/intl.dart';
import '../components/card_evenement.dart';

/// la page de l'onglet "Evenements" de l'agenda
/// avec en entete le des boutons de filtre pour classer les evenements
/// selon les 3 derniers jours, la semaine en cours, le mois en cours
class Evenements extends StatefulWidget {
  const Evenements({super.key, required this.userId});
  final String userId;

  @override
  State<Evenements> createState() => _EvenementsState();
}

class _EvenementsState extends State<Evenements> {
  EvenementViewModel evenementViewModel = EvenementViewModel();
  late Future<List<Evenement>> _events;
  late bool _joursSelected;
  late bool _semaineSelected;
  late bool _moisSelected;

  @override
  initState() {
    super.initState();
    _joursSelected = true;
    _semaineSelected = false;
    _moisSelected = false;
    _events = evenementViewModel.listerEnAttentePatient3Jours(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          _events,
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ));
          } else if (snapshot.hasData) {
            final List<List<Evenement>> data = snapshot.data!;
            final evenements = data[0];
            if (evenements.isNotEmpty) {
              //liste non vide
              // ignore: avoid_unnecessary_containers
              return Container(
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FilterChip(
                              selected: _joursSelected,
                              label: const Text('3 jours'),
                              onSelected: (bool selected) {
                                _select3Jours();
                              },
                            ),
                            FilterChip(
                              selected: _semaineSelected,
                              label: const Text('Semaine'),
                              onSelected: (bool selected) {
                                _selectSemaine();
                              },
                            ),
                            FilterChip(
                              selected: _moisSelected,
                              label: const Text('Mois'),
                              onSelected: (bool selected) {
                                _selectMois();
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 20),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                            color: Colors.grey[100],
                          ),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              mainAxisExtent: 200,
                            ),
                            itemCount: evenements.length,
                            itemBuilder: (context, index) {
                              return CardEvenement(
                                userId: widget.userId,
                                evenement: evenements[index],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              // ignore: avoid_unnecessary_containers
              return Container(
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FilterChip(
                              selected: _joursSelected,
                              label: const Text('3 jours'),
                              onSelected: (bool selected) {
                                _select3Jours();
                              },
                            ),
                            FilterChip(
                              selected: _semaineSelected,
                              label: const Text('Semaine'),
                              onSelected: (bool selected) {
                                _selectSemaine();
                              },
                            ),
                            FilterChip(
                              selected: _moisSelected,
                              label: const Text('Mois'),
                              onSelected: (bool selected) {
                                _selectMois();
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 20),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                            color: Colors.grey[100],
                          ),
                          child: const Center(
                            child: Text(
                              'Aucun évènement pour le moment',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          //en cas d'erreur quelconque (snapshot.hasError)
          return Center(child: Text('Erreur: ${snapshot.error}'));
        });
  }

  void _select3Jours() {
    if (kDebugMode) {
      print('3 jours selected');
    }
    setState(() {
      _joursSelected = true;
      _semaineSelected = false;
      _moisSelected = false;
      _events = evenementViewModel.listerEnAttentePatient3Jours(widget.userId);
    });
  }

  void _selectSemaine() {
    if (kDebugMode) {
      print('semaine selected');
    }
    setState(() {
      _semaineSelected = true;
      _moisSelected = false;
      _joursSelected = false;
      _events = evenementViewModel.listerEnAttentePatientSemaine(widget.userId);
    });
  }

  void _selectMois() {
    if (kDebugMode) {
      print('mois selected');
    }
    setState(() {
      _moisSelected = true;
      _semaineSelected = false;
      _joursSelected = false;
      _events = evenementViewModel.lister(); //test
      //_events = evenementViewModel.listerEnAttentePatientMois(widget.userId);
    });
  }
}
