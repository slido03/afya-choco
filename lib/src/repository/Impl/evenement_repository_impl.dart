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
            isEqualTo: rendezVous.dateHeure.millisecondsSinceEpoch)
        .where('rendez-vous.medecin.uid', isEqualTo: rendezVous.medecin.uid)
        .where('rendez-vous.patient.uid', isEqualTo: rendezVous.patient.uid)
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
  Future<void> modifier(Evenement evenement) {
    return evenements
        .where('rendez-vous.dateHeure',
            isEqualTo: evenement.rendezVous.dateHeure.millisecondsSinceEpoch)
        .where('rendez-vous.medecin.uid',
            isEqualTo: evenement.rendezVous.medecin.uid)
        .where('rendez-vous.patient.uid',
            isEqualTo: evenement.rendezVous.patient.uid)
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
  Future<List<Evenement>> listerPatient(String uidPatient) async {
    return await evenements
        .where('rendez-vous.patient.uid', isEqualTo: uidPatient)
        .orderBy('rendez-vous.dateHeure', descending: true)
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
  Future<List<Evenement>> listerMedecin(String uidMedecin) async {
    return await evenements
        .where('rendez-vous.medecin.uid', isEqualTo: uidMedecin)
        .orderBy('rendez-vous.dateHeure', descending: true)
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
  Future<void> supprimer(RendezVous rendezVous) {
    return evenements
        .where('rendez-vous.dateHeure',
            isEqualTo: rendezVous.dateHeure.millisecondsSinceEpoch)
        .where('rendez-vous.medecin.uid', isEqualTo: rendezVous.medecin.uid)
        .where('rendez-vous.patient.uid', isEqualTo: rendezVous.patient.uid)
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
