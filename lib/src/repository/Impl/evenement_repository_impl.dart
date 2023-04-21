import 'package:flutter/foundation.dart';

import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EvenementRepositoryImpl extends EvenementRepository {
  static EvenementRepository? _instance;
  static final _firestore = FirebaseFirestore.instance;
  final evenements = _firestore
      .collection('evenements')
      .withConverter<Evenement>(
        fromFirestore: (snapshot, _) => Evenement.fromJson(snapshot.data()!),
        toFirestore: (evenement, _) => evenement.toJson(),
      ); //collection evenements

  EvenementRepositoryImpl._() {
    //on initialise le cache local de firestore
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: 20 * 1024 * 1024,
    );
  } //constructeur privé

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
        .where('rendezVous.dateHeure',
            isEqualTo: rendezVous.dateHeure.millisecondsSinceEpoch)
        .where('rendezVous.medecin.uid', isEqualTo: rendezVous.medecin.uid)
        .where('rendezVous.patient.uid', isEqualTo: rendezVous.patient.uid)
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
        print(onError.toString());
      }
      return null;
    });
  }

  @override
  Future<void> modifier(Evenement evenement) {
    return evenements
        .where('rendezVous.dateHeure',
            isEqualTo: evenement.rendezVous.dateHeure.millisecondsSinceEpoch)
        .where('rendezVous.medecin.uid',
            isEqualTo: evenement.rendezVous.medecin.uid)
        .where('rendezVous.patient.uid',
            isEqualTo: evenement.rendezVous.patient.uid)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            evenement,
            SetOptions(mergeFields: [
              'titre',
              'description',
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
  Future<List<Evenement>> lister() async {
    return await evenements
        .orderBy('rendezVous.dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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

  //liste des évènements en attente dans les 3 jours suivants
  @override
  Future<List<Evenement>> listerEnAttentePatient3Jours(
      String uidPatient) async {
    return await evenements
        .where('rendezVous.patient.uid', isEqualTo: uidPatient)
        .where('rendezVous.dateHeure',
            isGreaterThan: DateTime.now().millisecondsSinceEpoch)
        .where('rendezVous.dateHeure',
            isLessThan: DateTime.now()
                .add(const Duration(days: 3))
                .millisecondsSinceEpoch)
        .orderBy('rendezVous.dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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

  //liste des évènements en attente dans la semaine suivante
  @override
  Future<List<Evenement>> listerEnAttentePatientSemaine(
      String uidPatient) async {
    return await evenements
        .where('rendezVous.patient.uid', isEqualTo: uidPatient)
        .where('rendezVous.dateHeure',
            isGreaterThan: DateTime.now().millisecondsSinceEpoch)
        .where('rendezVous.dateHeure',
            isLessThan: DateTime.now()
                .add(const Duration(days: 7))
                .millisecondsSinceEpoch)
        .orderBy('rendezVous.dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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

  //liste des évènements en attente dans le mois suivant
  @override
  Future<List<Evenement>> listerEnAttentePatientMois(String uidPatient) async {
    return await evenements
        .where('rendezVous.patient.uid', isEqualTo: uidPatient)
        .where('rendezVous.dateHeure',
            isGreaterThan: DateTime.now().millisecondsSinceEpoch)
        .where('rendezVous.dateHeure',
            isLessThan: DateTime.now()
                .add(const Duration(days: 30))
                .millisecondsSinceEpoch)
        .orderBy('rendezVous.dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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

  //liste des évènements en attente dans les 3 jours suivants
  @override
  Future<List<Evenement>> listerEnAttenteMedecin3Jours(
      String uidMedecin) async {
    return await evenements
        .where('rendezVous.medecin.uid', isEqualTo: uidMedecin)
        .where('rendezVous.dateHeure',
            isGreaterThan: DateTime.now().millisecondsSinceEpoch)
        .where('rendezVous.dateHeure',
            isLessThan: DateTime.now()
                .add(const Duration(days: 3))
                .millisecondsSinceEpoch)
        .orderBy('rendezVous.dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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

  //liste des évènements en attente dans la semaine suivante
  @override
  Future<List<Evenement>> listerEnAttenteMedecinSemaine(
      String uidMedecin) async {
    return await evenements
        .where('rendezVous.medecin.uid', isEqualTo: uidMedecin)
        .where('rendezVous.dateHeure',
            isGreaterThan: DateTime.now().millisecondsSinceEpoch)
        .where('rendezVous.dateHeure',
            isLessThan: DateTime.now()
                .add(const Duration(days: 7))
                .millisecondsSinceEpoch)
        .orderBy('rendezVous.dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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

  //liste des évènements en attente dans le mois suivant
  @override
  Future<List<Evenement>> listerEnAttenteMedecinMois(String uidMedecin) async {
    return await evenements
        .where('rendezVous.medecin.uid', isEqualTo: uidMedecin)
        .where('rendezVous.dateHeure',
            isGreaterThan: DateTime.now().millisecondsSinceEpoch)
        .where('rendezVous.dateHeure',
            isLessThan: DateTime.now()
                .add(const Duration(days: 30))
                .millisecondsSinceEpoch)
        .orderBy('rendezVous.dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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
  Future<List<Evenement>> listerPassePatient(String uidPatient) async {
    return await evenements
        .where('rendezVous.patient.uid', isEqualTo: uidPatient)
        .where('rendezVous.dateHeure',
            isLessThan: DateTime.now().millisecondsSinceEpoch)
        .orderBy('rendezVous.dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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
  Future<List<Evenement>> listerPasseMedecin(String uidMedecin) async {
    return await evenements
        .where('rendezVous.medecin.uid', isEqualTo: uidMedecin)
        .where('rendezVous.dateHeure',
            isLessThan: DateTime.now().millisecondsSinceEpoch)
        .orderBy('rendezVous.dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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
        .where('rendezVous.dateHeure',
            isEqualTo: rendezVous.dateHeure.millisecondsSinceEpoch)
        .where('rendezVous.medecin.uid', isEqualTo: rendezVous.medecin.uid)
        .where('rendezVous.patient.uid', isEqualTo: rendezVous.patient.uid)
        .get(const GetOptions(source: Source.serverAndCache))
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
}
