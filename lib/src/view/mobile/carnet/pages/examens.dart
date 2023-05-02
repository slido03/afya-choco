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
  final filterStateCategorie = {
    'categorie': 1,
  };
  final filterStateMois = {
    'mois': 1,
  };
  List<Specialite> categories =
      Specialite.values; //liste de toutes les spécialités
  ExamenViewModel examenViewModel = ExamenViewModel();
  late Future<List<Examen>> _exams;
  late int _categorie;
  late int _mois;

  @override
  initState() {
    super.initState();
    _categorie = 1; //Tous
    _mois = 1; //Tous
    _exams = examenViewModel.listerPatient(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: Future.wait([
          _exams,
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
                            filterState: filterStateCategorie,
                            onChanged: onChangedCategorie,
                          ),
                          const SizedBox(height: 15),
                          DropDownMois(
                            filterState: filterStateMois,
                            width: width * 0.80,
                            onChanged: onChangedMois,
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
              //liste vide
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
                            filterState: filterStateCategorie,
                            onChanged: onChangedCategorie,
                          ),
                          const SizedBox(height: 15),
                          DropDownMois(
                            filterState: filterStateMois,
                            width: width * 0.80,
                            onChanged: onChangedMois,
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Text(
                          'Aucun examen enregistré',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                    )
                  ],
                )),
              );
            }
          }
          //en cas d'erreur quelconque (snapshot.hasError)
          return Center(child: Text('Erreur: ${snapshot.error}'));
        });
  }

  void onChangedCategorie(int? value, String? filter) {
    setState(() {
      filterStateCategorie[filter!] = value!;
      _categorie = value;
      if ((_mois == 1) && (_categorie > 1)) {
        //si tous les mois sont sélectionnés et une catégorie spécifique
        //est sélectionnée
        _exams = examenViewModel.listerPatientSpecialite(
          categories[_categorie - 2],
          widget.userId,
        );
      } else if ((_mois > 1) && (_categorie > 1)) {
        //au cas contraire si un mois et une catégorie précis sont choisis
        _exams = examenViewModel.listerPatientSpecialiteMois(
          categories[_categorie - 2],
          _mois - 1,
          widget.userId,
        );
      } else if ((_categorie == 1) && (_mois == 1)) {
        _exams = examenViewModel.listerPatient(widget.userId);
      }
    });
    if (kDebugMode) {
      print(filterStateCategorie);
    }
  }

  void onChangedMois(int? value, String? filter) {
    setState(() {
      filterStateMois[filter!] = value!;
      _mois = value;
      if ((_categorie == 1) && (_mois > 1)) {
        //si toutes les catégories sont sélectionnées et un mois spécifique
        //est sélectionné
        _exams = examenViewModel.listerPatientMois(
          _mois - 1,
          widget.userId,
        );
      } else if ((_categorie > 1) && (_mois > 1)) {
        //au cas contaire si une catégorie et un mois précis sont choisis
        _exams = examenViewModel.listerPatientSpecialiteMois(
          categories[_categorie - 2],
          _mois - 1,
          widget.userId,
        );
      } else if ((_categorie == 1) && (_mois == 1)) {
        _exams = examenViewModel.listerPatient(widget.userId);
      }
    });
    if (kDebugMode) {
      print(filterStateMois);
    }
  }
}

extension FormatDate on DateTime {
  String get dateFormatted => DateFormat('dd/MM/yyyy').format(this);
  String get timeFormatted => DateFormat('HH:mm').format(this);
}
