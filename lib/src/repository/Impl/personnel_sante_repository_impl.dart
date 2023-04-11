import 'package:flutter/foundation.dart';

import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonnelSanteRepositoryImpl extends PersonnelSanteRepository {
  static PersonnelSanteRepository? _instance;
  final personnelsantes = FirebaseFirestore.instance
      .collection('personnelsantes')
      .withConverter<PersonnelSante>(
        fromFirestore: (snapshot, _) =>
            PersonnelSante.fromJson(snapshot.data()!),
        toFirestore: (personnelsante, _) => personnelsante.toJson(),
      ); //collection personnelsantes

  PersonnelSanteRepositoryImpl._(); //constructeur privé

  static PersonnelSanteRepository get instance {
    _instance ??= PersonnelSanteRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<PersonnelSante?> ajouter(PersonnelSante personnelsante) async {
    //si l'id généré est unique alors on ajouter le personnelsante
    if (_checkID(personnelsante)) {
      //on crée un personnel santé avec comme référence de document son uid
      //on procède ainsi afin de faciliter l'édition des règles de sécurité firestore
      //précisément pour contrôler les types des entités humaines
      await personnelsantes.doc(personnelsante.uid).set(personnelsante);
      return personnelsante;
    } else {
      return null;
    }
  }

  @override
  Future<PersonnelSante?> trouver(String identifiant) async {
    return await personnelsantes
        .where('identifiant', isEqualTo: identifiant)
        .get()
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
  Future<PersonnelSante?> trouverUid(String uid) async {
    return await personnelsantes.doc(uid).get().then((snapshot) {
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
  Future<void> modifier(PersonnelSante personnelsante) {
    return personnelsantes
        .where('identifiant', isEqualTo: personnelsante.identifiant)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            personnelsante,
            SetOptions(mergeFields: [
              'nom',
              'prenoms',
              'telephone',
              'email',
              'adresse',
              'clinique',
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
  Future<List<PersonnelSante>> lister() async {
    return await personnelsantes.get().then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<PersonnelSante> liste = [];
        for (var document in snapshot.docs) {
          PersonnelSante personnelsante = document.data();
          liste.add(personnelsante);
        }
        return liste;
      } else {
        List<PersonnelSante> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<void> supprimer(String identifiant) {
    return personnelsantes
        .where('identifiant', isEqualTo: identifiant)
        .get()
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

  bool _checkID(PersonnelSante personnelsante) {
    personnelsantes.get().then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          if (doc['identifiant'] == personnelsante.identifiant) {
            //on s'assure que le nouveau personnel santé a un ID unique en base données
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
