import 'package:afya/src/model/models.dart';
import 'package:flutter/material.dart';
//import 'dart:async';
//import '../components/card_evenement.dart';
//import '../components/card_rappel.dart';
import '../components/card_historique.dart';

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
  // la collection des evenements qui sera remplie par la base de donnees, donc ceci n'est q'un exemple de donnees test
  List<Rappel> collectionHistoriques = [
    Rappel(
      "Rappel de consultation du Dr. Jean",
      null,
      DateTime.now(),
      Evenement(
        "consultation du Dr. Jean",
        "consultation pour un mal de tête, je suis malade depuis 3 jours"
            "Rendez-vous du 12/12/2020 à 12h, pour des examens approfondis"
            "être à l'heure, et ne pas oublier votre carte vitale",
        RendezVous(
          DateTime.now(),
          30,
          Patient(
              "ES7284D", //uid
              "6382BY3", //id
              "Jean",
              "Dupont",
              "93750300",
              "felindelaplace@hotmail.com", //email
              "12 rue de la paix, 75000 Paris", //adresse
              DateTime.now(), //date de naissance
              Sexe.homme),
          Medecin(
            "ES7284D", //uid
            "6382BY3",
            "Jean",
            "Dupont",
            "93750300",
            "edmond234@hotmail.com", //email
            "12 rue de la paix, 75000 Paris", //adresse
            "La sante meilleure",
            true,
            Specialite.anesthesiologie,
            Secretaire(
              "ES7284D", //uid
              "6382BY3",
              "Jean",
              "Dupont",
              "93750300",
              "edmond234@hotmail.com", //email
              "12 rue de la paix, 75000 Paris", //adresse
              "La sante meilleure",
            ),
          ), //clinique
          "12 rue de la paix, 75000 Paris",
          ObjetRendezVous.consultation,
          StatutRendezVous.enAttente,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Center(
        child: Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: collectionHistoriques.isEmpty
                ? const Center(
                    child: Text(
                      'Aucun Rappel',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: 16, // ou collectionHistoriques.length
                    itemBuilder: (context, index) {
                      return CardHistorique();
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
