import 'package:afya/src/model/models.dart';
import 'package:flutter/material.dart';

import '../components/card_rappel.dart';

/// la page de l'onglet "Rappels" de l'agenda
/// avec en entete le des boutons de filtre pour classer les evenements
/// selon les 3 derniers jours, la semaine en cours, le mois en cours
class Rappels extends StatefulWidget {
  const Rappels({super.key});

  @override
  State<Rappels> createState() => _RappelsState();
}

class _RappelsState extends State<Rappels> {
  // la collection des evenements qui sera remplie par la base de donnees, donc ceci n'est q'un exemple de donnees test
  List<Rappel> collectionRappels = [
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
            "34827DE",
            Secretaire(
              "ES7284D", //uid
              "6382BY3",
              "Jean",
              "Dupont",
              "93750300",
              "edmond234@hotmail.com", //email
              "12 rue de la paix, 75000 Paris", //adresse
              "La sante meilleure",
              "34827DE",
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
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                  color: Color.fromRGBO(37, 211, 102, 0.12),
                ),
                child: collectionRappels.isEmpty
                    ? const Center(
                        child: Text(
                          'Aucun Rappel',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 24,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: 16, // ou collectionRappels.length
                        itemBuilder: (context, index) {
                          return CardRappel();
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
