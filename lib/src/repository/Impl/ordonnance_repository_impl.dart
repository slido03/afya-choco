import 'package:flutter/foundation.dart';

import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdonnanceRepositoryImpl extends OrdonnanceRepository {
  static OrdonnanceRepository? _instance;
  static final _firestore = FirebaseFirestore.instance;
  final ordonnances = _firestore
      .collection('ordonnances')
      .withConverter<Ordonnance>(
        fromFirestore: (snapshot, _) => Ordonnance.fromJson(snapshot.data()!),
        toFirestore: (ordonnance, _) => ordonnance.toJson(),
      ); //collection ordonnances

  OrdonnanceRepositoryImpl._() {
    //on initialise le cache local de firestore
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: 15 * 1024 * 1024,
    );
  } //constructeur privé

  static OrdonnanceRepository get instance {
    _instance ??= OrdonnanceRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<Ordonnance> ajouter(Ordonnance ordonnance) async {
    //ajoute l'ordonnance à la collection
    await ordonnances.add(ordonnance);
    return ordonnance;
  }

  @override
  Future<Ordonnance?> trouver(Diagnostic diagnostic) async {
    return await ordonnances
        .where('diagnostic.medecin.identifiant',
            isEqualTo: diagnostic.medecin.identifiant)
        .where('diagnostic.patient.identifiant',
            isEqualTo: diagnostic.patient!.identifiant)
        .where('diagnostic.date',
            isEqualTo: diagnostic.date.millisecondsSinceEpoch)
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
        // ignore: avoid_print
        print(onError.toString());
      }
      return null;
    });
  }

  @override
  Future<void> modifier(Ordonnance ordonnance) {
    return ordonnances
        .where('diagnostic.medecin.identifiant',
            isEqualTo: ordonnance.diagnostic.medecin.identifiant)
        .where('diagnostic.patient.identifiant',
            isEqualTo: ordonnance.diagnostic.patient!.identifiant)
        .where('diagnostic.date',
            isEqualTo: ordonnance.diagnostic.date.millisecondsSinceEpoch)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            ordonnance,
            SetOptions(mergeFields: [
              'instructions',
            ]));
      }
    }).catchError((onError) {
      if (kDebugMode) {
        // ignore: avoid_print
        print(onError.toString());
      }
      return null;
    });
  }

  @override
  Future<List<Ordonnance>> listerPatient(String uidPatient) async {
    return await ordonnances
        .where('patient.uid', isEqualTo: uidPatient)
        .orderBy('date', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Ordonnance> liste = [];
        for (var document in snapshot.docs) {
          Ordonnance ordonnance = document.data();
          liste.add(ordonnance);
        }
        return liste;
      } else {
        List<Ordonnance> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<List<Ordonnance>> listerMedecin(String uidMedecin) async {
    return await ordonnances
        .where('medecin.uid', isEqualTo: uidMedecin)
        .orderBy('date', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Ordonnance> liste = [];
        for (var document in snapshot.docs) {
          Ordonnance ordonnance = document.data();
          liste.add(ordonnance);
        }
        return liste;
      } else {
        List<Ordonnance> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<void> supprimer(Ordonnance ordonnance) {
    return ordonnances
        .where('diagnostic.date',
            isEqualTo: ordonnance.diagnostic.date.millisecondsSinceEpoch)
        .where('diagnostic.medecin.identifiant',
            isEqualTo: ordonnance.diagnostic.medecin.identifiant)
        .where('diagnostic.patient.identifiant',
            isEqualTo: ordonnance.diagnostic.patient!.identifiant)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var document in snapshot.docs) {
          document.reference.delete();
        }
      }
    }).catchError((onError) {
      if (kDebugMode) {
        // ignore: avoid_print
        print(onError.toString());
      }
      return null;
    });
  }
}
