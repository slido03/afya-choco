import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CarnetRepositoryImpl extends CarnetRepository {
  static CarnetRepository? _instance;
  final carnets =
      FirebaseFirestore.instance.collection('carnets').withConverter<Carnet>(
            fromFirestore: (snapshot, _) => Carnet.fromJson(snapshot.data()!),
            toFirestore: (carnet, _) => carnet.toJson(),
          ); //collection carnets

  CarnetRepositoryImpl._(); //constructeur privé

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
  Future<List<Carnet>> lister() async {
    return await carnets.get().then((snapshot) {
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
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var document in snapshot.docs) {
          document.reference.delete();
        }
      }
    }).catchError((onError) => null);
  }
}
