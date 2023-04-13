//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:afya/src/viewModel/examen_view_model.dart';
import 'package:afya/src/model/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:afya/src/view/mobile/carnet/components/components.dart';

class Examens extends StatefulWidget {
  const Examens({super.key, required this.userId});
  final String userId;

  @override
  State<Examens> createState() => _ExamensState();
}

class _ExamensState extends State<Examens> {
  final filterState = {
    'resultat': 1,
    'categorie': 1,
    'mois': 1,
  };

  ExamenViewModel examenViewModel = ExamenViewModel();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Future<List<Examen>> exams = examenViewModel.listerPatient(widget.userId);

    return FutureBuilder(
        future: Future.wait([
          exams,
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ));
          } else if (snapshot.hasData) {
            final List<List<Examen>> data = snapshot.data!;
            final examens = data[0];
            if (examens.isNotEmpty) {
              //liste non vide
              return Container(
                color: Colors.white12,
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          // box-shadow: only on the bottom
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          DropDownCategories(
                            width: width * 0.80,
                            filterState: filterState,
                            onChanged: onChanged,
                          ),
                          const SizedBox(height: 15),
                          DropDownMois(
                            filterState: filterState,
                            width: width * 0.80,
                            onChanged: onChanged,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: examens.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.all(1.0),
                                child: ListTile(
                                  title: Text(examens[index].type.value),
                                  subtitle:
                                      Text('Dr. ${examens[index].medecin.nom}'),
                                  trailing:
                                      Text(examens[index].date.dateFormatted),
                                ),
                              );
                            },
                          )),
                    )
                  ],
                )),
              );
            } else {
              return const Center(
                  child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  'Aucun examen enregistré pour le moment',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ));
            }
          }
          //en cas d'erreur quelconque (snapshot.hasError)
          return Center(child: Text('Erreur: ${snapshot.error}'));
        });
  }

  void onChanged(int? value, String? filter) {
    setState(() {
      filterState[filter!] = value!;
    });
    if (kDebugMode) {
      print(filterState);
    }
  }
}

extension FormatDate on DateTime {
  String get dateFormatted => DateFormat('dd/MM/yyyy').format(this);
  String get timeFormatted => DateFormat('HH:mm').format(this);
}
