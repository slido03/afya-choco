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
      await personnelsantes.add(personnelsante);
      return personnelsante;
    } else {
      return null;
    }
  }

  @override
  Future<PersonnelSante?> trouver(String identifiant) async {
    return await personnelsantes
        .where('identifiant', isEqualTo: identifiant)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.single.exists) {
        return snapshot.docs.single.data();
      } else {
        return null;
      }
    }).catchError((onError) => null);
  }

  @override
  Future<PersonnelSante?> trouverUid(String uid) async {
    return await personnelsantes
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.single.exists) {
        return snapshot.docs.single.data();
      } else {
        return null;
      }
    }).catchError((onError) => null);
  }

  @override
  Future<void> modifier(PersonnelSante personnelsante) {
    return personnelsantes
        .where('identifiant', isEqualTo: personnelsante.identifiant)
        .limit(1)
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
    }).catchError((onError) => null);
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
    }).catchError((onError) => null);
  }

  bool _checkID(PersonnelSante personnelsante) {
    bool checked = true;
    personnelsantes.get().then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          if (doc['identifiant'] == personnelsante.identifiant) {
            //on s'assure que le nouveau personnel santé a un ID unique en base données
            checked = false;
          }
        }
      }
    }).catchError((error) => error);
    return checked;
  }
}
