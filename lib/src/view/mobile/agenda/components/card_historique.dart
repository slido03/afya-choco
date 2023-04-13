import 'package:afya/src/repository/repositories.dart';
import 'package:afya/src/view/mobile/agenda/pages/historiques.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../model/models.dart';
import 'package:afya/src/viewModel/view_models.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CardHistorique extends StatelessWidget {
  const CardHistorique({super.key, required this.evenement});
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
            onSelected: (int value) async {
              if (value == 1) {
                _showDialog(context);
              } else if (value == 2) {
                EvenementViewModel evenementViewModel = EvenementViewModel();
                String userId = evenement.rendezVous.patient.uid;
                EasyLoading.show(status: 'suppression en cours');
                await evenementViewModel
                    .supprimer(evenement.rendezVous); //on supprime l'évènement
                EasyLoading.dismiss();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Historiques(userId: userId),
                  ),
                );
              }
            },
          ),
          title: Text(
            "${evenement.titre}\n"
            "${evenement.rendezVous.dateHeure.dateFormatted} à "
            "${evenement.rendezVous.dateHeure.timeFormatted}\n",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            evenement.description,
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

extension DateFormattedHistorique on DateTime {
  String get numberJourMois {
    String? number;
    String? jour;
    String? mois;
    number = DateFormat('EEE').format(this);
    if (day < 10) {
      String j = '0$day';
      jour = ' $j ';
    }
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
