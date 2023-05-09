import 'package:flutter/foundation.dart';
import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CarnetRepositoryImpl extends CarnetRepository {
  static CarnetRepository? _instance;
  static final _firestore = FirebaseFirestore.instance;
  final carnets = _firestore.collection('carnets').withConverter<Carnet>(
        fromFirestore: (snapshot, _) => Carnet.fromJson(snapshot.data()!),
        toFirestore: (carnet, _) => carnet.toJson(),
      ); //collection carnets

  CarnetRepositoryImpl._() {
    //on initialise le cache local de firestore
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: 25 * 1024 * 1024,
    );
  } //constructeur privé

  static CarnetRepository get instance {
    _instance ??= CarnetRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<Carnet> ajouter(Carnet carnet) async {
    //ajoute le carnet à la collection
    await carnets.add(carnet);
    return carnet;
  }

  @override
  Future<Carnet?> trouver(String identifiantPatient) async {
    return await carnets
        .where('proprietaire.identifiant', isEqualTo: identifiantPatient)
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
  Future<List<Carnet>> lister() async {
    return await carnets
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Carnet> liste = [];
        for (var document in snapshot.docs) {
          Carnet carnet = document.data();
          liste.add(carnet);
        }
        return liste;
      } else {
        List<Carnet> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<void> supprimer(String identifiantPatient) {
    return carnets
        .where('proprietaire.identifiant', isEqualTo: identifiantPatient)
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
