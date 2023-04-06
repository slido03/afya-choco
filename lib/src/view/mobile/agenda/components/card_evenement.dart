import 'package:afya/src/model/models.dart';
import 'package:afya/src/repository/repositories.dart';
import 'package:flutter/material.dart';

class CardEvenement extends StatelessWidget {
  //final Evenement evenement;

  //const CardEvenement({super.key, required this.evenement});

  CardEvenement({super.key});

  final evenement = Evenement(
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
          title: Text(evenement.titre),
          content: RichText(
            text: TextSpan(
              text: '${evenement.description}\n',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "\nDate: ${evenement.rendezVous.dateHeure.toString().split(" ")[0]}\n",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text:
                      "Heure: ${evenement.rendezVous.dateHeure.toString().split(" ")[1].split(":").sublist(0, 2).join(":")}\n",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: "Durée: ${evenement.rendezVous.duree} minutes\n",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text:
                      "Avec: Dr. ${evenement.rendezVous.medecin.nom} ${evenement.rendezVous.medecin.prenoms}\n",
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
        // ignore: sized_box_for_whitespace
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.event_available),
                title: const Text("Rendez-vous"),
                subtitle: Text(evenement.rendezVous.dateHeure.toString()),
              ),
              const SizedBox(
                height: 10,
              ),
              const ListTile(
                title: Text("Créer un rappel"),
                subtitle: Text(
                    "Un rappel sera créé pour vous 30 minutes avant le rendez-vous"),
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
    return GestureDetector(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          //width: MediaQuery.of(context).size.width * 0.3,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromRGBO(212, 251, 227, 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.event_available,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              const SizedBox(height: 5),
              Text(
                evenement.rendezVous.dateHeure.toString().split(" ")[
                    0], // a modifier lors de la connexion avec la base de données; format de date : lun 12 oct
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                evenement.titre,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                evenement.description,
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
                    evenement.rendezVous.dateHeure
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
            ],
          ),
        ),
      ),
      onTap: () {
        _showDialog(context);
      },
    );
  }
}
