//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Ordonnances extends StatefulWidget {
  const Ordonnances({super.key});

  @override
  State<Ordonnances> createState() => _OrdonnancesState();
}

class _OrdonnancesState extends State<Ordonnances> {
  final filterState = {
    'resultat': 1,
    'categorie': 1,
    'mois': 1,
  };

  // getting the data from firestore
  //final ordonnances = FirebaseFirestore.instance.collection('ordonnances').snapshots();
  // Ordonnances shemas
  /*
    Examen(
    date,
    type,
    patient,
    resultats : Map<String, String>
  );
  */
  // generating the list of ordonnances wirh random data : random name, random date : all fake data
  List<Map<String, dynamic>> ordonnances = [
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
    // ignore: unused_local_variable
    var size = MediaQuery.of(context).size.width;

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
                            ['type']), // ou la spécialité du médécin.
                        subtitle: Text(ordonnances[index]['medecin']),
                        trailing: Text(DateFormat('dd/MM/yyyy')
                            .format(ordonnances[index]['date'])),
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
