import 'package:flutter/foundation.dart';

import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RappelRepositoryImpl extends RappelRepository {
  static RappelRepository? _instance;
  static final _firestore = FirebaseFirestore.instance;
  final rappels = _firestore.collection('rappels').withConverter<Rappel>(
        fromFirestore: (snapshot, _) => Rappel.fromJson(snapshot.data()!),
        toFirestore: (rappel, _) => rappel.toJson(),
      ); //collection rappels

  RappelRepositoryImpl._() {
    //on initialise le cache local de firestore
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: 15 * 1024 * 1024,
    );
  } //constructeur privé

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
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            rappel,
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
  Future<List<Rappel>> lister() async {
    return await rappels
        .orderBy('dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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
  Future<List<Rappel>> listerEnAttentePatient3Jours(String uidPatient) async {
    return await rappels
        .where('evenement.rendezVous.patient.uid', isEqualTo: uidPatient)
        .where('dateHeure',
            isGreaterThan: DateTime.now().millisecondsSinceEpoch)
        .where('dateHeure',
            isLessThan: DateTime.now()
                .add(const Duration(days: 3))
                .millisecondsSinceEpoch)
        .orderBy('dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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
  Future<List<Rappel>> listerEnAttentePatientSemaine(String uidPatient) async {
    return await rappels
        .where('evenement.rendezVous.patient.uid', isEqualTo: uidPatient)
        .where('dateHeure',
            isGreaterThan: DateTime.now().millisecondsSinceEpoch)
        .where('dateHeure',
            isLessThan: DateTime.now()
                .add(const Duration(days: 7))
                .millisecondsSinceEpoch)
        .orderBy('dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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
  Future<List<Rappel>> listerEnAttentePatientMois(String uidPatient) async {
    return await rappels
        .where('evenement.rendezVous.patient.uid', isEqualTo: uidPatient)
        .where('dateHeure',
            isGreaterThan: DateTime.now().millisecondsSinceEpoch)
        .where('dateHeure',
            isLessThan: DateTime.now()
                .add(const Duration(days: 30))
                .millisecondsSinceEpoch)
        .orderBy('dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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
  Future<List<Rappel>> listerEnAttenteMedecin3Jours(String uidMedecin) async {
    return await rappels
        .where('evenement.rendezVous.medecin.uid', isEqualTo: uidMedecin)
        .where('dateHeure',
            isGreaterThan: DateTime.now().millisecondsSinceEpoch)
        .where('dateHeure',
            isLessThan: DateTime.now()
                .add(const Duration(days: 3))
                .millisecondsSinceEpoch)
        .orderBy('dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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
  Future<List<Rappel>> listerEnAttenteMedecinSemaine(String uidMedecin) async {
    return await rappels
        .where('evenement.rendezVous.medecin.uid', isEqualTo: uidMedecin)
        .where('dateHeure',
            isGreaterThan: DateTime.now().millisecondsSinceEpoch)
        .where('dateHeure',
            isLessThan: DateTime.now()
                .add(const Duration(days: 7))
                .millisecondsSinceEpoch)
        .orderBy('dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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
  Future<List<Rappel>> listerEnAttenteMedecinMois(String uidMedecin) async {
    return await rappels
        .where('evenement.rendezVous.medecin.uid', isEqualTo: uidMedecin)
        .where('dateHeure',
            isGreaterThan: DateTime.now().millisecondsSinceEpoch)
        .where('dateHeure',
            isLessThan: DateTime.now()
                .add(const Duration(days: 30))
                .millisecondsSinceEpoch)
        .orderBy('dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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
  Future<List<Rappel>> listerPassePatient(String uidPatient) async {
    return await rappels
        .where('evenement.rendezVous.patient.uid', isEqualTo: uidPatient)
        .where('dateHeure', isLessThan: DateTime.now().millisecondsSinceEpoch)
        .orderBy('dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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
  Future<List<Rappel>> listerPasseMedecin(String uidMedecin) async {
    return await rappels
        .where('evenement.rendezVous.medecin.uid', isEqualTo: uidMedecin)
        .where('dateHeure', isLessThan: DateTime.now().millisecondsSinceEpoch)
        .orderBy('dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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
  Future<List<Rappel>> listerEvenement(Evenement evenement) async {
    return await rappels
        .where('evenement.rendezVous.dateHeure',
            isEqualTo: evenement.rendezVous.dateHeure.millisecondsSinceEpoch)
        .where('evenement.rendezVous.medecin.uid',
            isEqualTo: evenement.rendezVous.medecin.uid)
        .where('evenement.rendezVous.patient.uid',
            isEqualTo: evenement.rendezVous.patient.uid)
        .orderBy('dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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
