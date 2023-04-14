import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SecretaireRepositoryImpl extends SecretaireRepository {
  static SecretaireRepository? _instance;
  static final _firestore = FirebaseFirestore.instance;
  final secretaires = _firestore
      .collection('secretaires')
      .withConverter<Secretaire>(
        fromFirestore: (snapshot, _) => Secretaire.fromJson(snapshot.data()!),
        toFirestore: (secretaire, _) => secretaire.toJson(),
      ); //collection secretaires

  SecretaireRepositoryImpl._() {
    //on initialise le cache local de firestore
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: 30 * 1024 * 1024,
    );
  } //constructeur privé

  static SecretaireRepository get instance {
    _instance ??= SecretaireRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<Secretaire?> ajouter(Secretaire secretaire) async {
    //si l'id généré est unique alors on ajouter le secretaire
    if (_checkID(secretaire)) {
      //on crée un secrétaire avec comme référence de document son uid
      //on procède ainsi afin de faciliter l'édition des règles de sécurité firestore
      //précisément pour contrôler les types des entités humaines
      await secretaires.doc(secretaire.uid).set(secretaire);
      return secretaire;
    } else {
      return null;
    }
  }

  @override
  Future<Secretaire?> trouver(String identifiant) async {
    return await secretaires
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
  Future<Secretaire?> trouverUid(String uid) async {
    return await secretaires
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
  Future<Secretaire?> getSecretariatCentral() async {
    return await secretaires
        .where('identifiant', isEqualTo: 'AAAA1111')
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
  Future<void> modifier(Secretaire secretaire) {
    return secretaires
        .where('identifiant', isEqualTo: secretaire.identifiant)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            secretaire,
            SetOptions(mergeFields: [
              'nom',
              'prenoms',
              'telephone',
              'email',
              'adresse',
              'clinique',
              //'medecins',
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
  Future<List<Secretaire>> lister() async {
    return await secretaires
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Secretaire> liste = [];
        for (var document in snapshot.docs) {
          Secretaire secretaire = document.data();
          liste.add(secretaire);
        }
        return liste;
      } else {
        List<Secretaire> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<void> supprimer(String identifiant) {
    return secretaires
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

  bool _checkID(Secretaire secretaire) {
    secretaires.get(const GetOptions(source: Source.server)).then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          if (doc['identifiant'] == secretaire.identifiant) {
            //on s'assure que le nouveau secretaire a un ID unique en base données
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
