import 'package:afya/src/model/models.dart';
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

  @override
  Widget build(BuildContext context) {
    Future<List<Rappel>> raps = rappelViewModel.lister();

    return FutureBuilder(
        future: Future.wait([
          raps,
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
                          child: ListView.builder(
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
              return const Center(
                child: Text(
                  'Aucun rappel pour le moment',
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
