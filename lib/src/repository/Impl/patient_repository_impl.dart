import 'package:flutter/foundation.dart';

import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientRepositoryImpl extends PatientRepository {
  static PatientRepository? _instance;
  static final _firestore = FirebaseFirestore.instance;
  final patients = _firestore.collection('patients').withConverter<Patient>(
        fromFirestore: (snapshot, _) => Patient.fromJson(snapshot.data()!),
        toFirestore: (patient, _) => patient.toJson(),
      ); //collection patients

  PatientRepositoryImpl._() {
    //on initialise le cache local de firestore
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: 70 * 1024 * 1024,
    );
  } //constructeur privé

  static PatientRepository get instance {
    _instance ??= PatientRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<Patient?> ajouter(Patient patient) async {
    //si l'id généré est unique alors on ajouter le patient
    if (_checkID(patient)) {
      //on crée un patient avec comme référence de document son uid
      //on procède ainsi afin de faciliter l'édition des règles de sécurité firestore
      //précisément pour contrôler les types des entités humaines
      await patients.doc(patient.uid).set(patient);
      return patient;
    } else {
      return null;
    }
  }

  @override
  Future<Patient?> trouver(String identifiant) async {
    return await patients
        .where('identifiant', isEqualTo: identifiant)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        if (snapshot.docs.first.exists) {
          return snapshot.docs.first.data();
        }
      } else {
        return null;
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      return null;
    });
  }

  @override
  Future<Patient?> trouverUid(String uid) async {
    return await patients
        .doc(uid)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.exists) {
        return snapshot.data();
      } else {
        return null;
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      return null;
    });
  }

  @override
  Future<void> modifier(Patient patient) {
    return patients
        .where('identifiant', isEqualTo: patient.identifiant)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            patient,
            SetOptions(mergeFields: [
              'nom',
              'prenoms',
              'telephone',
              'email',
              'adresse',
              'dateNaissance',
              'sexe',
            ]));
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      return null;
    });
  }

  @override
  Future<List<Patient>> lister() async {
    return await patients
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Patient> liste = [];
        for (var document in snapshot.docs) {
          Patient patient = document.data();
          liste.add(patient);
        }
        return liste;
      } else {
        List<Patient> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<void> supprimer(String identifiant) {
    return patients
        .where('identifiant', isEqualTo: identifiant)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var document in snapshot.docs) {
          document.reference.delete();
        }
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      return null;
    });
  }

  bool _checkID(Patient patient) {
    patients.get(const GetOptions(source: Source.server)).then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          if (doc['identifiant'] == patient.identifiant) {
            //on s'assure que le nouveau patient a un ID unique en base données
            return false;
          }
        }
      } else {
        return true;
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return false;
    });
    return true;
  }
}
