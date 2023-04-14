import 'package:flutter/foundation.dart';

import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiagnosticRepositoryImpl extends DiagnosticRepository {
  static DiagnosticRepository? _instance;
  static final _firestore = FirebaseFirestore.instance;
  final diagnostics = _firestore
      .collection('diagnostics')
      .withConverter<Diagnostic>(
        fromFirestore: (snapshot, _) => Diagnostic.fromJson(snapshot.data()!),
        toFirestore: (diagnostic, _) => diagnostic.toJson(),
      ); //collection diagnostics

  DiagnosticRepositoryImpl._() {
    //on initialise le cache local de firestore
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: 15 * 1024 * 1024,
    );
  } //constructeur privé

  static DiagnosticRepository get instance {
    _instance ??= DiagnosticRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<Diagnostic> ajouter(Diagnostic diagnostic) async {
    //ajoute le diagnostic à la collection
    await diagnostics.add(diagnostic);
    return diagnostic;
  }

  @override
  Future<Diagnostic?> trouver(
      DateTime date, Medecin medecin, Patient patient) async {
    return await diagnostics
        .where('date', isEqualTo: date.millisecondsSinceEpoch)
        .where('medecin.identifiant', isEqualTo: medecin.identifiant)
        .where('patient.identifiant', isEqualTo: patient.identifiant)
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
  Future<void> modifier(Diagnostic diagnostic) {
    return diagnostics
        .where('date', isEqualTo: diagnostic.date.millisecondsSinceEpoch)
        .where('medecin.identifiant', isEqualTo: diagnostic.medecin.identifiant)
        .where('patient.identifiant',
            isEqualTo: diagnostic.patient!.identifiant)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            diagnostic,
            SetOptions(mergeFields: [
              'description',
              'examens',
              'patient',
              'statut',
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
  Future<List<Diagnostic>> listerPatient(Patient patient) async {
    return await diagnostics
        .where('patient.identifiant', isEqualTo: patient.identifiant)
        .orderBy('date', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Diagnostic> liste = [];
        for (var document in snapshot.docs) {
          Diagnostic diagnostic = document.data();
          liste.add(diagnostic);
        }
        return liste;
      } else {
        List<Diagnostic> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<List<Diagnostic>> listerMedecin(Medecin medecin) async {
    return await diagnostics
        .where('medecin.identifiant', isEqualTo: medecin.identifiant)
        .orderBy('date', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Diagnostic> liste = [];
        for (var document in snapshot.docs) {
          Diagnostic diagnostic = document.data();
          liste.add(diagnostic);
        }
        return liste;
      } else {
        List<Diagnostic> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<void> supprimer(Diagnostic diagnostic) {
    return diagnostics
        .where('date', isEqualTo: diagnostic.date.millisecondsSinceEpoch)
        .where('medecin.identifiant', isEqualTo: diagnostic.medecin.identifiant)
        .where('patient.identifiant',
            isEqualTo: diagnostic.patient!.identifiant)
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
