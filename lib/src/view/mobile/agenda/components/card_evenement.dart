import 'package:afya/src/model/models.dart';
import 'package:afya/src/repository/repositories.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:afya/src/view/mobile/agenda/components/form_note.dart';
import 'package:afya/src/view/mobile/agenda/components/form_rappel.dart';
import '../pages/notes.dart';

class CardEvenement extends StatelessWidget {
  const CardEvenement(
      {super.key, required this.userId, required this.evenement});
  final String userId;
  final Evenement evenement;

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
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "\nDate: ${evenement.rendezVous.dateHeure.dateFormatted}\n",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text:
                      "Heure: ${evenement.rendezVous.dateHeure.timeFormatted}\n",
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
          height: MediaQuery.of(context).size.height * 0.42,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.event_available),
                title: const Text("Rendez-vous"),
                subtitle: Text(evenement.rendezVous.dateHeure.numberJourMois),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text("Créer un rappel"),
                subtitle: const Text(
                    "Un rappel sera créé pour vous avant votre rendez-vous"),
                onTap: () {
                  //on le redirige vers la page de création de rappel
                  _navigateToFormRappel(context);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                title: const Text("Ajouter une note"),
                subtitle: const Text("Ajouter une note pour ce rendez-vous"),
                onTap: () {
                  //on le redirige vers la page de création de note
                  _navigateToFormNote(context);
                },
              ),
              ListTile(
                title: const Text("Voir vos notes"),
                subtitle: const Text("Voir vos notes sur cet évènement"),
                onTap: () {
                  //on le redirige vers la page des notes de l'évènement
                  _navigateToNotes(context);
                },
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
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          //width: MediaQuery.of(context).size.width * 0.3,
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                size: 24,
              ),
              const SizedBox(height: 5),
              Text(
                evenement.titre,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Text(
                evenement.description,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    evenement.rendezVous.dateHeure.numberJourMois,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
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

  void _navigateToFormRappel(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => FormRappel(evenement: evenement)),
    );
  }

  void _navigateToFormNote(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => FormNote(evenement: evenement)),
    );
  }

  void _navigateToNotes(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => Notes(userId: userId, evenement: evenement)),
    );
  }
}

extension DateFormattedEvenement on DateTime {
  String get numberJourMois {
    String? number;
    String? jour;
    String? mois;
    number = DateFormat('EEE', 'fr_FR').format(this);
    if (day < 10) {
      String j = '0$day';
      jour = ' $j ';
    }
    jour = ' $day ';
    switch (month) {
      case 1:
        mois = 'Jan';
        break;
      case 2:
        mois = 'Fev';
        break;
      case 3:
        mois = 'Mar';
        break;
      case 4:
        mois = 'Avr';
        break;
      case 5:
        mois = 'Mai';
        break;
      case 6:
        mois = 'Juin';
        break;
      case 7:
        mois = 'Jul';
        break;
      case 8:
        mois = 'Aôut';
        break;
      case 9:
        mois = 'Sep';
        break;
      case 10:
        mois = 'Oct';
        break;
      case 11:
        mois = 'Nov';
        break;
      case 12:
        mois = 'Dec';
        break;
    }
    return '$number$jour$mois';
  }

  String get dateFormatted => DateFormat('dd/MM/yyyy').format(this);
  String get timeFormatted => DateFormat('HH:mm').format(this);
}
