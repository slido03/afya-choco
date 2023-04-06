import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RendezVousRepositoryImpl extends RendezVousRepository {
  static RendezVousRepository? _instance;
  final rendezvous = FirebaseFirestore.instance
      .collection('rendezvouss')
      .withConverter<RendezVous>(
        fromFirestore: (snapshot, _) => RendezVous.fromJson(snapshot.data()!),
        toFirestore: (rendezvous, _) => rendezvous.toJson(),
      ); //collection rendezvouss

  RendezVousRepositoryImpl._(); //constructeur privé

  static RendezVousRepository get instance {
    _instance ??= RendezVousRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<RendezVous> ajouter(RendezVous rendezVous) async {
    //ajoute le rappel à la collection
    await rendezvous.add(rendezVous);
    return rendezVous;
  }

  @override
  Future<RendezVous?> trouver(
      DateTime dateHeure, Patient patient, Medecin medecin) async {
    return await rendezvous
        .where('dateHeure', isEqualTo: dateHeure.millisecondsSinceEpoch)
        .where('medecin.uid', isEqualTo: medecin.uid)
        .where('patient.uid', isEqualTo: patient.uid)
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
  Future<void> modifier(RendezVous rendezVous) {
    return rendezvous
        .where('dateHeure',
            isEqualTo: rendezVous.dateHeure.millisecondsSinceEpoch)
        .where('medecin.uid', isEqualTo: rendezVous.medecin.uid)
        .where('patient.uid', isEqualTo: rendezVous.patient.uid)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            rendezVous,
            SetOptions(mergeFields: [
              'dateHeure',
              'duree',
              'lieu',
              'statut',
            ]));
      }
    }).catchError((onError) => null);
  }

  @override
  Future<List<RendezVous>> listerPatient(String uidPatient) async {
    return await rendezvous
        .where('patient.uid', isEqualTo: uidPatient)
        .orderBy('dateHeure', descending: true)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<RendezVous> liste = [];
        for (var document in snapshot.docs) {
          RendezVous rendezVous = document.data();
          liste.add(rendezVous);
        }
        return liste;
      } else {
        List<RendezVous> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<List<RendezVous>> listerMedecin(String uidMedecin) async {
    return await rendezvous
        .where('medecin.uid', isEqualTo: uidMedecin)
        .orderBy('dateHeure', descending: true)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<RendezVous> liste = [];
        for (var document in snapshot.docs) {
          RendezVous rendezVous = document.data();
          liste.add(rendezVous);
        }
        return liste;
      } else {
        List<RendezVous> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<List<RendezVous>> listerEnAttentePatient(String uidPatient) async {
    return await rendezvous
        .where('patient.uid', isEqualTo: uidPatient)
        .where('dateHeure',
            isGreaterThan: DateTime.now().millisecondsSinceEpoch)
        .orderBy('dateHeure', descending: true)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<RendezVous> liste = [];
        for (var document in snapshot.docs) {
          RendezVous rendezVous = document.data();
          liste.add(rendezVous);
        }
        return liste;
      } else {
        List<RendezVous> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<List<RendezVous>> listerEnAttenteMedecin(String uidMedecin) async {
    return await rendezvous
        .where('medecin.uid', isEqualTo: uidMedecin)
        .where('dateHeure',
            isGreaterThan: DateTime.now().millisecondsSinceEpoch)
        .orderBy('dateHeure', descending: true)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<RendezVous> liste = [];
        for (var document in snapshot.docs) {
          RendezVous rendezVous = document.data();
          liste.add(rendezVous);
        }
        return liste;
      } else {
        List<RendezVous> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<RendezVous?> getLastForPatient(String uidPatient) async {
    //liste des rendez-vous du patient du plus récent au plus ancien
    List<RendezVous> liste = await listerPatient(uidPatient);
    if (liste.isNotEmpty) {
      return liste.first;
    } else {
      return null;
    }
  }

  @override
  Future<RendezVous?> getLastForMedecin(String uidMedecin) async {
    //liste des rendez-vous du patient du plus récent au plus ancien
    List<RendezVous> liste = await listerMedecin(uidMedecin);
    if (liste.isNotEmpty) {
      return liste.first;
    } else {
      return null;
    }
  }

  @override
  Future<void> supprimer(RendezVous rendezVous) {
    return rendezvous
        .where('dateHeure',
            isEqualTo: rendezVous.dateHeure.millisecondsSinceEpoch)
        .where('medecin.uid', isEqualTo: rendezVous.medecin.uid)
        .where('patient.uid', isEqualTo: rendezVous.patient.uid)
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
