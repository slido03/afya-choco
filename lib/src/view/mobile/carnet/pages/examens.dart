//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/drop_down_categories.dart';
import '../components/drop_down_mois.dart';

class Examens extends StatefulWidget {
  const Examens({super.key});

  @override
  State<Examens> createState() => _ExamensState();
}

class _ExamensState extends State<Examens> {
  final filterState = {
    'resultat': 1,
    'categorie': 1,
    'mois': 1,
  };

  // getting the data from firestore
  //final examens = FirebaseFirestore.instance.collection('examens').snapshots();
  // Examens shemas
  /*
    Examen(
    date,
    type,
    patient,
    resultats : Map<String, String>
  );
  */
  // generating the list of examens wirh random data : random name, random date : all fake data
  List<Map<String, dynamic>> examens = [
    {
      'date': DateTime.now(),
      'type': 'Radiologie',
      'patient': 'Moussa',
      'medecin': 'Dr. TEPE',
      'resultats': {
        'Radiologie': 'Normal',
        'Hemogramme': 'Anormal',
        'Electrocardiogramme': 'Normal',
      }
    },
    {
      'date': DateTime.now(),
      'type': 'Radiologie',
      'patient': 'Moussa',
      'medecin': 'Dr. TEPE',
      'resultats': {
        'Radiologie': 'Normal',
        'Hemogramme': 'Anormal',
        'Electrocardiogramme': 'Normal',
      }
    },
    {
      'date': DateTime.now(),
      'type': 'Radiologie',
      'patient': 'Moussa',
      'medecin': 'Dr. TEPE',
      'resultats': {
        'Radiologie': 'Normal',
        'Hemogramme': 'Anormal',
        'Electrocardiogramme': 'Normal',
      }
    },
    {
      'date': DateTime.now(),
      'type': 'Radiologie',
      'patient': 'Moussa',
      'medecin': 'Dr. TEPE',
      'resultats': {
        'Radiologie': 'Normal',
        'Hemogramme': 'Anormal',
        'Electrocardiogramme': 'Normal',
      }
    },
    {
      'date': DateTime.now(),
      'type': 'Radiologie',
      'patient': 'Moussa',
      'medecin': 'Dr. TEPE',
      'resultats': {
        'Radiologie': 'Normal',
        'Hemogramme': 'Anormal',
        'Electrocardiogramme': 'Normal',
      }
    },
    {
      'date': DateTime.now(),
      'type': 'Radiologie',
      'patient': 'Moussa',
      'medecin': 'Dr. TEPE',
      'resultats': {
        'Radiologie': 'Normal',
        'Hemogramme': 'Anormal',
        'Electrocardiogramme': 'Normal',
      }
    },
    {
      'date': DateTime.now(),
      'type': 'Radiologie',
      'patient': 'Moussa',
      'medecin': 'Dr. TEPE',
      'resultats': {
        'Radiologie': 'Normal',
        'Hemogramme': 'Anormal',
        'Electrocardiogramme': 'Normal',
      }
    },
    {
      'date': DateTime.now(),
      'type': 'Radiologie',
      'patient': 'Moussa',
      'medecin': 'Dr. TEPE',
      'resultats': {
        'Radiologie': 'Normal',
        'Hemogramme': 'Anormal',
        'Electrocardiogramme': 'Normal',
      }
    },
    {
      'date': DateTime.now(),
      'type': 'Radiologie',
      'patient': 'Moussa',
      'medecin': 'Dr. TEPE',
      'resultats ': {
        'Radiologie': 'Normal',
        'Hemogramme': 'Anormal',
        'Electrocardiogramme': 'Normal',
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

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
                  offset: const Offset(0, 3), // changes position of shadow
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
                  width: width*0.80,
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
                        title: Text(examens[index]['type']),
                        subtitle: Text(examens[index]['medecin']),
                        trailing: Text(DateFormat('dd/MM/yyyy')
                            .format(examens[index]['date'])),
                      ),
                    );
                  },
                )),
          )
        ],
      )),
    );
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
