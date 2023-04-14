import 'package:flutter/foundation.dart';

import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExamenRepositoryImpl extends ExamenRepository {
  static ExamenRepository? _instance;
  static final _firestore = FirebaseFirestore.instance;
  final examens = _firestore.collection('examens').withConverter<Examen>(
        fromFirestore: (snapshot, _) => Examen.fromJson(snapshot.data()!),
        toFirestore: (examen, _) => examen.toJson(),
      ); //collection examens

  ExamenRepositoryImpl._() {
    //on initialise le cache local de firestore
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: 20 * 1024 * 1024,
    );
  } //constructeur privé

  static ExamenRepository get instance {
    _instance ??= ExamenRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<Examen> ajouter(Examen examen) async {
    //ajoute l'examen à la collection
    await examens.add(examen);
    return examen;
  }

  @override
  Future<Examen?> trouver(
      Medecin medecin, Patient patient, Specialite type, DateTime date) async {
    return await examens
        .where('medecin.identifiant', isEqualTo: medecin.identifiant)
        .where('patient.identifiant', isEqualTo: patient.identifiant)
        .where('type', isEqualTo: type.name)
        .where('date', isEqualTo: date.millisecondsSinceEpoch)
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
  Future<void> modifier(Examen examen) {
    return examens
        .where('medecin.identifiant', isEqualTo: examen.medecin.identifiant)
        .where('patient.identifiant', isEqualTo: examen.patient.identifiant)
        .where('type', isEqualTo: examen.type.name)
        .where('date', isEqualTo: examen.date.millisecondsSinceEpoch)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            examen,
            SetOptions(mergeFields: [
              'resultats',
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
  Future<List<Examen>> listerMedecin(String uidMedecin) async {
    return await examens
        .where('medecin.uid', isEqualTo: uidMedecin)
        .orderBy('date', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Examen> liste = [];
        for (var document in snapshot.docs) {
          Examen examen = document.data();
          liste.add(examen);
        }
        return liste;
      } else {
        List<Examen> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<List<Examen>> listerPatient(String uidPatient) async {
    return await examens
        .where('patient.uid', isEqualTo: uidPatient)
        .orderBy('date', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Examen> liste = [];
        for (var document in snapshot.docs) {
          Examen examen = document.data();
          liste.add(examen);
        }
        return liste;
      } else {
        List<Examen> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<List<Examen>> listerSpecialite(
      Specialite type, String uidPatient) async {
    return await examens
        .where('patient.uid', isEqualTo: uidPatient)
        .where('type', isEqualTo: type.name)
        .orderBy('date', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Examen> liste = [];
        for (var document in snapshot.docs) {
          Examen examen = document.data();
          liste.add(examen);
        }
        return liste;
      } else {
        List<Examen> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<void> supprimer(Examen examen) {
    return examens
        .where('medecin.identifiant', isEqualTo: examen.medecin.identifiant)
        .where('patient.identifiant', isEqualTo: examen.patient.identifiant)
        .where('type', isEqualTo: examen.type.name)
        .where('date', isEqualTo: examen.date.millisecondsSinceEpoch)
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
}
