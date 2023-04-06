import 'package:afya/src/repository/repositories.dart';
import 'package:flutter/material.dart';

import '../../../../model/models.dart';

class CardHistorique extends StatelessWidget {
  //final Evenement historique;evenement.

  //const CardHistorique({super.key, required this.historique}evenement.);

  CardHistorique({super.key});

  final historique = Evenement(
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
  );

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(historique.titre),
          content: RichText(
            text: TextSpan(
              text: '${historique.description}\n',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "\nDate: ${historique.rendezVous.dateHeure.toString().split(" ")[0]}\n",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text:
                      "Heure: ${historique.rendezVous.dateHeure.toString().split(" ")[1].split(":").sublist(0, 2).join(":")}\n",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: "Durée: ${historique.rendezVous.duree} minutes\n",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text:
                      "Avec: Dr. ${historique.rendezVous.medecin.nom} ${historique.rendezVous.medecin.prenoms}\n",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.event_available),
                title: const Text("Rendez-vous"),
                subtitle: Text(historique.rendezVous.dateHeure.toString()),
              ),
              const SizedBox(
                height: 10,
              ),
              const ListTile(
                title: Text("Créer un historique"),
                subtitle: Text(
                    "Un historique evenement.sera créé pour vous 30 minutes avant le rendez-vous"),
                onTap:
                    null, // a modifier lors de la connexion avec la base de données
              ),
              const SizedBox(
                height: 5,
              ),
              const ListTile(
                title: Text("Ajouter une note"),
                subtitle: Text("Ajouter une note pour ce rendez-vous"),
                onTap:
                    null, // a modifier lors de la connexion avec la base de données
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        //width: MediaQuery.of(context).size.width * 0.3,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: ListTile(
          leading: Icon(
            Icons.history,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          trailing: PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 1,
                  child: Text("Voir plus"),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text("Supprimer"),
                ),
              ];
            },
            onSelected: (int value) {
              if (value == 1) {
                _showDialog(context);
              } else if (value == 2) {
                // a modifier lors de la connexion avec la base de données
                // supprimer le historique
              }
            },
          ),
          title: Text(
            "${historique.titre}\n"
            "${historique.rendezVous.dateHeure.toString().split(" ")[0]} à "
            "${historique.rendezVous.dateHeure.toString().split(" ")[1].split(":").sublist(0, 2).join(":")}\n",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            historique.description,
            style: const TextStyle(
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            _showDialog(context);
          },
        ),
      ),
    );
  }
}

/*

              Text(
                historique.rendezVous.dateHeure.toString().split(" ")[
                    0], // a modifier lors de la connexion avec la base de données; format de date : lun 12 oct
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 5),
              
              const SizedBox(height: 5),
              Text(
                historique.description,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    historique.rendezVous.dateHeure
                        .toString()
                        .split(" ")[1]
                        .split(":")
                        .sublist(0, 2)
                        .join(":"),
                    // a modifier lors de la connexion avec la base de données; format de date : lun 12 oct
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      _showBottomSheetMenu(context);
                    },
                  )
                ],
              ), 
*/