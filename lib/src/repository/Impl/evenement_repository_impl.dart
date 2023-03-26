import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EvenementRepositoryImpl extends EvenementRepository {
  static EvenementRepository? _instance;
  final evenements = FirebaseFirestore.instance
      .collection('evenements')
      .withConverter<Evenement>(
        fromFirestore: (snapshot, _) => Evenement.fromJson(snapshot.data()!),
        toFirestore: (evenement, _) => evenement.toJson(),
      ); //collection evenements

  EvenementRepositoryImpl._(); //constructeur privé

  static EvenementRepository get instance {
    _instance ??= EvenementRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<Evenement> ajouter(Evenement evenement) async {
    //ajoute l'évènement à la collection
    await evenements.add(evenement);
    return evenement;
  }

  @override
  Future<Evenement?> trouver(RendezVous rendezVous) async {
    return await evenements
        .where('rendez-vous.dateHeure',
            isEqualTo: rendezVous.dateHeure.toIso8601String())
        .where('rendez-vous.medecin.identifiant',
            isEqualTo: rendezVous.medecin.identifiant)
        .where('rendez-vous.patient.identifiant',
            isEqualTo: rendezVous.patient.identifiant)
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
  Future<void> modifier(Evenement evenement) {
    return evenements
        .where('rendez-vous.dateHeure',
            isEqualTo: evenement.rendezVous.dateHeure.toIso8601String())
        .where('rendez-vous.medecin.identifiant',
            isEqualTo: evenement.rendezVous.medecin.identifiant)
        .where('rendez-vous.patient.identifiant',
            isEqualTo: evenement.rendezVous.patient.identifiant)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            evenement,
            SetOptions(mergeFields: [
              'titre',
              'description',
            ]));
      }
    }).catchError((onError) => null);
  }

  @override
  Future<List<Evenement>> listerEvenementPatient(Patient patient) async {
    return await evenements
        .where('rendez-vous.patient.identifiant',
            isEqualTo: patient.identifiant)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Evenement> liste = [];
        for (var document in snapshot.docs) {
          Evenement evenement = document.data();
          liste.add(evenement);
        }
        return liste;
      } else {
        List<Evenement> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<List<Evenement>> listerEvenementMedecin(Medecin medecin) async {
    return await evenements
        .where('rendez-vous.medecin.identifiant',
            isEqualTo: medecin.identifiant)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Evenement> liste = [];
        for (var document in snapshot.docs) {
          Evenement evenement = document.data();
          liste.add(evenement);
        }
        return liste;
      } else {
        List<Evenement> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<void> supprimer(Evenement evenement) {
    return evenements
        .where('rendez-vous.dateHeure',
            isEqualTo: evenement.rendezVous.dateHeure.toIso8601String())
        .where('rendez-vous.medecin.identifiant',
            isEqualTo: evenement.rendezVous.medecin.identifiant)
        .where('rendez-vous.patient.identifiant',
            isEqualTo: evenement.rendezVous.patient.identifiant)
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
