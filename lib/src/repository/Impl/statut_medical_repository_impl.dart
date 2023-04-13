import 'package:flutter/foundation.dart';

import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatutMedicalRepositoryImpl extends StatutMedicalRepository {
  static StatutMedicalRepository? _instance;
  static final _firestore = FirebaseFirestore.instance;
  final statutmedicaux =
      _firestore.collection('statutmedicaux').withConverter<StatutMedical>(
            fromFirestore: (snapshot, _) =>
                StatutMedical.fromJson(snapshot.data()!),
            toFirestore: (statutmedical, _) => statutmedical.toJson(),
          ); //collection statutmedicaux

  StatutMedicalRepositoryImpl._() {
    //on initialise le cache local de firestore
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: 70 * 1024 * 1024,
    );
  } //constructeur privé

  static StatutMedicalRepository get instance {
    _instance ??= StatutMedicalRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<StatutMedical> ajouter(StatutMedical statutmedical) async {
    //ajoute le rappel à la collection
    await statutmedicaux.add(statutmedical);
    return statutmedical;
  }

  @override
  Future<StatutMedical?> trouver(String identifiantPatient) async {
    return await statutmedicaux
        .where('patient.identifiant', isEqualTo: identifiantPatient)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data();
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
  Future<StatutMedical?> trouverUid(String uidPatient) async {
    return await statutmedicaux
        .where('patient.uid', isEqualTo: uidPatient)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data();
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
  Future<void> modifier(StatutMedical statutmedical) {
    return statutmedicaux
        .where('patient.identifiant',
            isEqualTo: statutmedical.patient.identifiant)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            statutmedical,
            SetOptions(mergeFields: [
              'groupeSanguin',
              'allergies',
              'maladiesHereditaires',
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
  Future<List<StatutMedical>> lister() async {
    return await statutmedicaux
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<StatutMedical> liste = [];
        for (var document in snapshot.docs) {
          StatutMedical statutMedical = document.data();
          liste.add(statutMedical);
        }
        return liste;
      } else {
        List<StatutMedical> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<void> supprimer(String identifiantPatient) {
    return statutmedicaux
        .where('patient.identifiant', isEqualTo: identifiantPatient)
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
