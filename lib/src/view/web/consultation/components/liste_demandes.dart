import 'package:afya/src/repository/repositories.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:afya/src/viewModel/message_view_model.dart';
import 'package:provider/provider.dart';

class ListeDemandes extends StatefulWidget {
  const ListeDemandes({
    super.key,
    required this.messages,
  });
  final Future<List<Message>> messages;

  @override
  State<ListeDemandes> createState() => _ListeDemandeState();
}

class _ListeDemandeState extends State<ListeDemandes> {
  //  List<Map<String, dynamic>> demandes = [
  //   {
  //     'date':  DateTime(2023, 3, 26),
  //     'heure': '12:00',
  //     'sender': 'Monsieur Jean',
  //     'description': 'Maux de tete atroce, besoin de prise en charge',
  //     'readed': false,
  //   },
  //    {
  //     'date':  DateTime(2023, 3, 26),
  //     'heure': '12:00',
  //     'sender': 'Monsieur Jean',
  //     'description': 'Maux de tete atroce, besoin de prise en charge',
  //     'readed': true,
  //   }, {
  //     'date':  DateTime(2023, 3, 26),
  //     'heure': '12:00',
  //     'sender': 'Monsieur Jean',
  //     'description': 'Maux de tete atroce, besoin de prise en charge',
  //     'readed': true,
  //   }, {
  //     'date':  DateTime(2023, 3, 26),
  //     'heure': '12:00',
  //     'sender': 'Monsieur Jean',
  //     'description': 'Maux de tete atroce, besoin de prise en charge',
  //     'readed': false,
  //   }, {
  //     'date':  DateTime(2023, 3, 26),
  //     'heure': '12:00',
  //     'sender': 'Monsieur Jean',
  //     'description': 'Maux de tete atroce, besoin de prise en charge',
  //     'readed': true,
  //   }, {
  //     'date':  DateTime(2023, 3, 26),
  //     'heure': '12:00',
  //     'sender': 'Monsieur Jean',
  //     'description': 'Maux de tete atroce, besoin de prise en charge',
  //     'readed': false,
  //   }, {
  //     'date':  DateTime(2023, 3, 26),
  //     'heure': '12:00',
  //     'sender': 'Monsieur Jean',
  //     'description': 'Maux de tete atroce, besoin de prise en charge',
  //     'readed': false,
  //   }, {
  //     'date':  DateTime(2023, 3, 26),
  //     'heure': '12:00',
  //     'sender': 'Monsieur Jean',
  //     'description': 'Maux de tete atroce, besoin de prise en charge',
  //     'readed': false,
  //   },
  //    {
  //     'date':  DateTime(2023, 3, 26),
  //     'heure': '12:00',
  //     'sender': 'Monsieur Jean',
  //     'description': 'Maux de tete atroce, besoin de prise en charge',
  //     'readed': false,
  //   },
  //    {
  //     'date':  DateTime(2023, 3, 26),
  //     'heure': '12:00',
  //     'sender': 'Monsieur Jean',
  //     'description': 'Maux de tete atroce, besoin de prise en charge',
  //     'readed': false,
  //   },
  //    {
  //     'date':  DateTime(2023, 3, 26),
  //     'heure': '12:00',
  //     'sender': 'Monsieur Jean',
  //     'description': 'Maux de tete atroce, besoin de prise en charge',
  //     'readed': false,
  //   },
  //    {
  //     'date':  DateTime(2023, 3, 26),
  //     'heure': '12:00',
  //     'sender': 'Monsieur Jean',
  //     'description': 'Maux de tete atroce, besoin de prise en charge',
  //     'readed': false,
  //   },

  // ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageViewModel>(
        builder: (context, messageViewModel, child) {
      return StreamBuilder<List<Message>>(
          stream: Stream.fromFuture(widget.messages),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ));
            } else if (snapshot.hasData) {
              //si le stream contient des données
              final msgRecus = snapshot.data;
              if (msgRecus != null) {
                msgRecus.isEmpty
                    ? const Center(
                        child: Text(
                        'Pas de demande pour le moment',
                        style: TextStyle(color: Colors.black),
                      ))
                    : ListView.builder(
                        //shrinkWrap: true,
                        itemCount: msgRecus.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              child: ListTile(
                                  dense: true,
                                  title: Text(
                                    msgRecus[index].dateHeure.numberJourMois,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        msgRecus[index].expediteur.nomComplet,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        msgRecus[index].contenu,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        msgRecus[index].dateHeure.timeFormatted,
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      (msgRecus[index].statut ==
                                              StatutMessage.traite)
                                          ? const SizedBox()
                                          : const Icon(
                                              Icons.circle,
                                              size: 10,
                                              color: Colors.green,
                                            ),
                                    ],
                                  )));
                        },
                      );
              } else {
                return const Center(
                    child: Text(
                  'Pas de demande pour le moment',
                  style: TextStyle(color: Colors.black),
                ));
              }
            }
            return Center(child: Text('erreur : ${snapshot.error}'));
          });
    });
  }
}

extension FormatDate on DateTime {
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
