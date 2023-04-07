import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RappelRepositoryImpl extends RappelRepository {
  static RappelRepository? _instance;
  final rappels =
      FirebaseFirestore.instance.collection('rappels').withConverter<Rappel>(
            fromFirestore: (snapshot, _) => Rappel.fromJson(snapshot.data()!),
            toFirestore: (rappel, _) => rappel.toJson(),
          ); //collection rappels

  RappelRepositoryImpl._(); //constructeur privé

  static RappelRepository get instance {
    _instance ??= RappelRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<Rappel> ajouter(Rappel rappel) async {
    //ajoute le rappel à la collection
    await rappels.add(rappel);
    return rappel;
  }

  @override
  Future<Rappel?> trouver(DateTime dateHeure, Evenement evenement) async {
    return await rappels
        .where('dateHeure', isEqualTo: dateHeure.millisecondsSinceEpoch)
        .where('evenement.rendezVous.dateHeure',
            isEqualTo: evenement.rendezVous.dateHeure.millisecondsSinceEpoch)
        .where('evenement.rendezVous.medecin.uid',
            isEqualTo: evenement.rendezVous.medecin.uid)
        .where('evenement.rendezVous.patient.uid',
            isEqualTo: evenement.rendezVous.patient.uid)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        if (snapshot.docs.first.exists) {
          return snapshot.docs.first.data();
        }
      } else {
        return null;
      }
    }).catchError((onError) => null);
  }

  @override
  Future<void> modifier(Rappel rappel) {
    return rappels
        .where('dateHeure', isEqualTo: rappel.dateHeure.millisecondsSinceEpoch)
        .where('evenement.rendezVous.dateHeure',
            isEqualTo:
                rappel.evenement.rendezVous.dateHeure.millisecondsSinceEpoch)
        .where('evenement.rendezVous.medecin.uid',
            isEqualTo: rappel.evenement.rendezVous.medecin.uid)
        .where('evenement.rendezVous.patient.uid',
            isEqualTo: rappel.evenement.rendezVous.patient.uid)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            rappel,
            SetOptions(mergeFields: [
              'titre',
              'description',
            ]));
      }
    }).catchError((onError) => null);
  }

  @override
  Future<List<Rappel>> lister(Evenement evenement) async {
    return await rappels
        .where('evenement.rendezVous.dateHeure',
            isEqualTo: evenement.rendezVous.dateHeure.millisecondsSinceEpoch)
        .where('evenement.rendezVous.medecin.uid',
            isEqualTo: evenement.rendezVous.medecin.uid)
        .where('evenement.rendezVous.patient.uid',
            isEqualTo: evenement.rendezVous.patient.uid)
        .orderBy('dateHeure', descending: true)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Rappel> liste = [];
        for (var document in snapshot.docs) {
          Rappel rappel = document.data();
          liste.add(rappel);
        }
        return liste;
      } else {
        List<Rappel> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<void> supprimer(Rappel rappel) {
    return rappels
        .where('dateHeure', isEqualTo: rappel.dateHeure.millisecondsSinceEpoch)
        .where('evenement.rendezVous.dateHeure',
            isEqualTo:
                rappel.evenement.rendezVous.dateHeure.millisecondsSinceEpoch)
        .where('evenement.rendezVous.medecin.uid',
            isEqualTo: rappel.evenement.rendezVous.medecin.uid)
        .where('evenement.rendezVous.patient.uid',
            isEqualTo: rappel.evenement.rendezVous.patient.uid)
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
