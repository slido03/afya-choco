import 'package:afya/src/model/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:afya/src/viewModel/view_models.dart';
import 'dart:async';
import '../components/card_rappel.dart';

/// la page de l'onglet "Rappels" de l'agenda
/// avec en entete des boutons de filtre pour classer les rappels
/// selon les 3 derniers jours, la semaine en cours, le mois en cours
class Rappels extends StatefulWidget {
  const Rappels({super.key, required this.userId});
  final String userId;

  @override
  State<Rappels> createState() => _RappelsState();
}

class _RappelsState extends State<Rappels> {
  RappelViewModel rappelViewModel = RappelViewModel();
  late Future<List<Rappel>> _rappels;
  late bool _joursSelected;
  late bool _semaineSelected;
  late bool _moisSelected;

  @override
  initState() {
    super.initState();
    _joursSelected = true;
    _semaineSelected = false;
    _moisSelected = false;
    _rappels = rappelViewModel.listerEnAttentePatient3Jours(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          _rappels,
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ));
          } else if (snapshot.hasData) {
            final List<List<Rappel>> data = snapshot.data!;
            final rappels = data[0];
            if (rappels.isNotEmpty) {
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
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: rappels.length,
                            itemBuilder: (context, index) {
                              return CardRappel(
                                rappel: rappels[index],
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
                              'Aucun rappel pour le moment',
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
      _rappels = rappelViewModel.listerEnAttentePatient3Jours(widget.userId);
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
      _rappels = rappelViewModel.listerEnAttentePatientSemaine(widget.userId);
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
      _rappels = rappelViewModel.listerEnAttentePatientMois(widget.userId);
    });
  }
}
