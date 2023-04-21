//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:afya/src/viewModel/view_models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
//import 'package:afya/src/viewModel/examen_view_model.dart';
import 'package:afya/src/model/models.dart';

class Ordonnances extends StatefulWidget {
  const Ordonnances({super.key, required this.userId});
  final String userId;

  @override
  State<Ordonnances> createState() => _OrdonnancesState();
}

class _OrdonnancesState extends State<Ordonnances> {
  OrdonnanceViewModel ordonnanceViewModel = OrdonnanceViewModel();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var size = MediaQuery.of(context).size.width;

    Future<List<Ordonnance>> ords =
        ordonnanceViewModel.listerPatient(widget.userId);

    return FutureBuilder(
        future: Future.wait([
          ords,
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ));
          } else if (snapshot.hasData) {
            final List<List<Ordonnance>> data = snapshot.data!;
            final ordonnances = data[0];
            //liste non vide
            if (ordonnances.isNotEmpty) {
              return Container(
                color: Colors.white12,
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Column(
                  children: [
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: ordonnances.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(ordonnances[index]
                                      .medecin
                                      .specialite
                                      .value), // spécialité du médécin.
                                  subtitle: Text(
                                      'Dr. ${ordonnances[index].medecin.nom}'),
                                  trailing: Text(
                                      ordonnances[index].date.dateFormatted),
                                ),
                              );
                            },
                          )),
                    )
                  ],
                )),
              );
            } else {
              return Container(
                color: Colors.white12,
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Column(
                  children: const [
                    Expanded(
                        child: Center(
                            child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        'Aucune ordonnance enregistrée',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )))
                  ],
                )),
              );
            }
          }
          //en cas d'erreur quelconque (snapshot.hasError)
          if (kDebugMode) {
            print(snapshot.error.toString());
          }
          return Center(child: Text('Erreur: ${snapshot.error}'));
        });
  }
}

extension FormatDate on DateTime {
  String get dateFormatted => DateFormat('dd/MM/yyyy').format(this);
  String get timeFormatted => DateFormat('HH:mm').format(this);
}
