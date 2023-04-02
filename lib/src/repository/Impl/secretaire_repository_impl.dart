import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SecretaireRepositoryImpl extends SecretaireRepository {
  static SecretaireRepository? _instance;
  final secretaires = FirebaseFirestore.instance
      .collection('secretaires')
      .withConverter<Secretaire>(
        fromFirestore: (snapshot, _) => Secretaire.fromJson(snapshot.data()!),
        toFirestore: (secretaire, _) => secretaire.toJson(),
      ); //collection secretaires

  SecretaireRepositoryImpl._(); //constructeur privé

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
  Future<Secretaire?> trouverUid(String uid) async {
    return await secretaires
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
  Future<void> modifier(Secretaire secretaire) {
    return secretaires
        .where('identifiant', isEqualTo: secretaire.identifiant)
        .limit(1)
        .get()
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
              'numeroSecuriteSociale',
              'medecins'
            ]));
      }
    }).catchError((onError) => null);
  }

  @override
  Future<List<Secretaire>> lister() async {
    return await secretaires.get().then((snapshot) {
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
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var document in snapshot.docs) {
          document.reference.delete();
        }
      }
    }).catchError((onError) => null);
  }

  bool _checkID(Secretaire secretaire) {
    bool checked = true;
    secretaires.get().then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          if (doc['identifiant'] == secretaire.identifiant) {
            //on s'assure que le nouveau secretaire a un ID unique en base données
            checked = false;
          }
        }
      }
    }).catchError((error) => error);
    return checked;
  }
}
