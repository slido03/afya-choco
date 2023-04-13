import 'package:flutter/foundation.dart';

import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientIntermediaireRepositoryImpl
    extends PatientIntermediaireRepository {
  static PatientIntermediaireRepository? _instance;
  static final _firestore = FirebaseFirestore.instance;
  final patientintermediaires = _firestore
      .collection('patientintermediaires')
      .withConverter<PatientIntermediaire>(
        fromFirestore: (snapshot, _) =>
            PatientIntermediaire.fromJson(snapshot.data()!),
        toFirestore: (patientintermediaire, _) => patientintermediaire.toJson(),
      ); //collection patientintermediaires

  PatientIntermediaireRepositoryImpl._() {
    //on initialise le cache local de firestore
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: 40 * 1024 * 1024,
    );
  } //constructeur privé

  static PatientIntermediaireRepository get instance {
    _instance ??= PatientIntermediaireRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<PatientIntermediaire?> ajouter(
      PatientIntermediaire patientintermediaire) async {
    //si l'id généré est unique alors on ajouter le patient intermediaire
    if (_checkTempID(patientintermediaire)) {
      //on crée un patient intermédiaire avec comme référence de document son uid
      //on procède ainsi afin de faciliter l'édition des règles de sécurité firestore
      //précisément pour contrôler les types des entités humaines
      await patientintermediaires
          .doc(patientintermediaire.uid)
          .set(patientintermediaire);
      return patientintermediaire;
    } else {
      return null;
    }
  }

  @override
  Future<PatientIntermediaire?> trouver(String identifiantTemporaire) async {
    return await patientintermediaires
        .where('identifiant', isEqualTo: identifiantTemporaire)
        .get(const GetOptions(source: Source.server))
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
  Future<PatientIntermediaire?> trouverUid(String uid) async {
    return await patientintermediaires
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
  Future<void> modifier(PatientIntermediaire patientintermediaire) {
    return patientintermediaires
        .where('identifiant',
            isEqualTo: patientintermediaire.identifiantTemporaire)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            patientintermediaire,
            SetOptions(mergeFields: [
              'nom',
              'prenoms',
              'telephone',
              'email',
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
  Future<List<PatientIntermediaire>> lister() async {
    return await patientintermediaires
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<PatientIntermediaire> liste = [];
        for (var document in snapshot.docs) {
          PatientIntermediaire patient = document.data();
          liste.add(patient);
        }
        return liste;
      } else {
        List<PatientIntermediaire> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<void> supprimer(String identifiantTemporaire) {
    return patientintermediaires
        .where('identifiant', isEqualTo: identifiantTemporaire)
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

  bool _checkTempID(PatientIntermediaire patient) {
    patientintermediaires
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          if (doc['identifiant'] == patient.identifiantTemporaire) {
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
