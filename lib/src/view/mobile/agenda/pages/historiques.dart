import 'package:afya/src/model/models.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../components/card_historique.dart';
import 'package:afya/src/viewModel/evenement_view_model.dart';

/// la page de l'onglet "Historiques" de l'agenda
/// avec en entete le des boutons de filtre pour classer les evenements
/// selon les 3 derniers jours, la semaine en cours, le mois en cours
class Historiques extends StatefulWidget {
  const Historiques({super.key, required this.userId});
  final String userId;

  @override
  State<Historiques> createState() => _HistoriquesState();
}

class _HistoriquesState extends State<Historiques> {
  EvenementViewModel evenementViewModel = EvenementViewModel();

  @override
  Widget build(BuildContext context) {
    Future<List<Evenement>> events =
        evenementViewModel.listerPassePatient(widget.userId);

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
              // ignore: avoid_unnecessary_containers
              return Container(
                child: Center(
                  child: Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ListView.builder(
                        itemCount: evenements.length,
                        itemBuilder: (context, index) {
                          return CardHistorique(
                            evenement: evenements[index],
                          );
                        },
                      ),
                    ),
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
