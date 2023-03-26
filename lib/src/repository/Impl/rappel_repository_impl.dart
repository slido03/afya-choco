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
        .where('dateHeure', isEqualTo: dateHeure.toIso8601String())
        .where('evenement.rendez-vous.dateHeure',
            isEqualTo: evenement.rendezVous.dateHeure.toIso8601String())
        .where('evenement.rendez-vous.medecin.identifiant',
            isEqualTo: evenement.rendezVous.medecin.identifiant)
        .where('evenement.rendez-vous.patient.identifiant',
            isEqualTo: evenement.rendezVous.patient.identifiant)
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
  Future<void> modifier(Rappel rappel) {
    return rappels
        .where('evenement.rendez-vous.dateHeure',
            isEqualTo: rappel.evenement.rendezVous.dateHeure.toIso8601String())
        .where('evenement.rendez-vous.medecin.identifiant',
            isEqualTo: rappel.evenement.rendezVous.medecin.identifiant)
        .where('evenement.rendez-vous.patient.identifiant',
            isEqualTo: rappel.evenement.rendezVous.patient.identifiant)
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
        .where('evenement.rendez-vous.dateHeure',
            isEqualTo: evenement.rendezVous.dateHeure.toIso8601String())
        .where('evenement.rendez-vous.medecin.identifiant',
            isEqualTo: evenement.rendezVous.medecin.identifiant)
        .where('evenement.rendez-vous.patient.identifiant',
            isEqualTo: evenement.rendezVous.patient.identifiant)
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
        .where('dateHeure', isEqualTo: rappel.dateHeure.toIso8601String())
        .where('evenement.rendez-vous.dateHeure',
            isEqualTo: rappel.evenement.rendezVous.dateHeure.toIso8601String())
        .where('evenement.rendez-vous.medecin.identifiant',
            isEqualTo: rappel.evenement.rendezVous.medecin.identifiant)
        .where('evenement.rendez-vous.patient.identifiant',
            isEqualTo: rappel.evenement.rendezVous.patient.identifiant)
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
