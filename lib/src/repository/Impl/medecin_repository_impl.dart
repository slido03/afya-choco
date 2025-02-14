import 'package:flutter/foundation.dart';

import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MedecinRepositoryImpl extends MedecinRepository {
  static MedecinRepository? _instance;
  static final _firestore = FirebaseFirestore.instance;
  final medecins = _firestore.collection('medecins').withConverter<Medecin>(
        fromFirestore: (snapshot, _) => Medecin.fromJson(snapshot.data()!),
        toFirestore: (medecin, _) => medecin.toJson(),
      ); //collection medecins

  MedecinRepositoryImpl._() {
    //on initialise le cache local de firestore
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: 20 * 1024 * 1024,
    );
  } //constructeur privé

  static MedecinRepository get instance {
    _instance ??= MedecinRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<Medecin?> ajouter(Medecin medecin) async {
    //si l'id généré est unique alors on ajouter le medecin
    if (_checkID(medecin)) {
      //on crée un médecin avec comme référence de document son uid
      //on procède ainsi afin de faciliter l'édition des règles de sécurité firestore
      //précisément pour contrôler les types des entités humaines
      await medecins.doc(medecin.uid).set(medecin);
      return medecin;
    } else {
      return null;
    }
  }

  @override
  Future<Medecin?> trouver(String identifiant) async {
    return await medecins
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
        // ignore: avoid_print
        print(onError.toString());
      }
      return null;
    });
  }

  @override
  Future<Medecin?> trouverUid(String uid) async {
    return await medecins.doc(uid).get().then((snapshot) {
      if (snapshot.exists) {
        return snapshot.data();
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
  Future<void> modifier(Medecin medecin) {
    return medecins
        .where('identifiant', isEqualTo: medecin.identifiant)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            medecin,
            SetOptions(mergeFields: [
              'nom',
              'prenoms',
              'telephone',
              'email',
              'adresse',
              'clinique',
              'admin',
              'specialite',
              'secretaire',
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
  Future<List<Medecin>> lister() async {
    return await medecins
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Medecin> liste = [];
        for (var document in snapshot.docs) {
          Medecin medecin = document.data();
          liste.add(medecin);
        }
        return liste;
      } else {
        List<Medecin> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<void> supprimer(String identifiant) {
    return medecins
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
        // ignore: avoid_print
        print(onError.toString());
      }
      return null;
    });
  }

  bool _checkID(Medecin medecin) {
    medecins.get(const GetOptions(source: Source.server)).then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          if (doc['identifiant'] == medecin.identifiant) {
            //on s'assure que le nouveau medecin a un ID unique en base données
            return false;
          }
        }
      } else {
        return true;
      }
    }).catchError((error) {
      if (kDebugMode) {
        // ignore: avoid_print
        print(error.toString());
      }
      return false;
    });
    return true;
  }
}
