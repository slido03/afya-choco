import 'package:afya/src/model/models.dart';
import 'package:afya/src/viewModel/evenement_view_model.dart';
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

  @override
  Widget build(BuildContext context) {
    Future<List<Evenement>> events =
        evenementViewModel.listerEnAttentePatient(widget.userId);

    return FutureBuilder(
        future: Future.wait([
          events,
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
                              label: const Text('3 jours'),
                              onSelected: (bool selected) {},
                            ),
                            FilterChip(
                              label: const Text('Semaine'),
                              onSelected: (bool selected) {},
                            ),
                            FilterChip(
                              selected: true,
                              label: const Text('Mois'),
                              onSelected: (bool selected) {},
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 20),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                            color: Color.fromRGBO(37, 211, 102, 0.12),
                          ),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  (MediaQuery.of(context).size.width < 390)
                                      ? 2
                                      : 3,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              mainAxisExtent: 185,
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
              return const Center(
                child: Text(
                  'Aucun évènement pour le moment',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              );
            }
          }
          //en cas d'erreur quelconque (snapshot.hasError)
          return Center(child: Text('Erreur: ${snapshot.error}'));
        });
  }
}
