import 'package:afya/src/model/models.dart';
import 'package:afya/src/repository/repositories.dart';
import 'package:afya/src/view/mobile/agenda/pages/rappels.dart';
import 'package:afya/src/viewModel/view_models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CardRappel extends StatelessWidget {
  const CardRappel({super.key, required this.rappel});
  final Rappel rappel;

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(rappel.evenement.titre),
          content: RichText(
            text: TextSpan(
              text: '${rappel.evenement.description}\n',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "\nDate: ${rappel.evenement.rendezVous.dateHeure.dateFormatted}\n",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text:
                      "Heure: ${rappel.evenement.rendezVous.dateHeure.timeFormatted}\n",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: "Durée: ${rappel.evenement.rendezVous.duree} minutes\n",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text:
                      "Avec: Dr. ${rappel.evenement.rendezVous.medecin.nom} ${rappel.evenement.rendezVous.medecin.prenoms}\n",
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
          color: const Color.fromRGBO(212, 251, 227, 1),
        ),
        child: ListTile(
          leading: Icon(
            Icons.alarm,
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
            onSelected: (int value) async {
              if (value == 1) {
                _showDialog(context);
              } else if (value == 2) {
                RappelViewModel rappelViewModel = RappelViewModel();
                String userId = rappel.evenement.rendezVous.patient.uid;
                EasyLoading.show(status: 'suppression en cours');
                await rappelViewModel.supprimer(rappel); //on supprime le rappel
                EasyLoading.dismiss();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Rappels(userId: userId),
                  ),
                );
              }
            },
          ),
          title: Text(
            "${rappel.titre}\n"
            "${rappel.dateHeure.dateFormatted} à "
            "${rappel.dateHeure.timeFormatted}\n",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            rappel.description!.isEmpty
                ? "Pas de description"
                : rappel.description!,
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

extension DateFormattedRappel on DateTime {
  String get numberJourMois {
    String? number;
    String? jour;
    String? mois;
    number = DateFormat('EEE').format(this);
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
