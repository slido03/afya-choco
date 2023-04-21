import 'package:afya/src/model/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../components/card_historique.dart';
import 'package:afya/src/viewModel/evenement_view_model.dart';

/// la page de l'onglet "Historiques" de l'agenda
/// avec en entete le des boutons de filtre pour classer les evenements
/// selon les 3 derniers jours, la semaine en cours, le mois en cours
class Historiques extends StatefulWidget {
  const Historiques({
    super.key,
    required this.userId,
  });
  final String userId;

  @override
  State<Historiques> createState() => _HistoriquesState();
}

class _HistoriquesState extends State<Historiques> {
  EvenementViewModel evenementViewModel = EvenementViewModel();

  @override
  Widget build(BuildContext context) {
    Future<List<Evenement>> events =
        evenementViewModel.listerPassePatient(widget.userId); //test

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
              if (kDebugMode) {
                print('evenements non vide');
              }
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 20,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: evenements.length,
                        itemBuilder: (context, index) {
                          return CardHistorique(
                            evenement: evenements[index],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              if (kDebugMode) {
                print('evenements vide');
              }
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
          } else if (snapshot.hasError) {
            if (kDebugMode) {
              print('erreur : snapshot.hasError');
            }
            //en cas d'erreur quelconque (snapshot.hasError)
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }
          return const Center(
            child: Text(
              'Aucun évènement pour le moment',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          );
        });
  }
}
