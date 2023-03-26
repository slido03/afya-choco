import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientIntermediaireRepositoryImpl
    extends PatientIntermediaireRepository {
  static PatientIntermediaireRepository? _instance;
  final patientintermediaires = FirebaseFirestore.instance
      .collection('patientintermediaires')
      .withConverter<PatientIntermediaire>(
        fromFirestore: (snapshot, _) =>
            PatientIntermediaire.fromJson(snapshot.data()!),
        toFirestore: (patientintermediaire, _) => patientintermediaire.toJson(),
      ); //collection patientintermediaires

  PatientIntermediaireRepositoryImpl._(); //constructeur privé

  static PatientIntermediaireRepository get instance {
    _instance ??= PatientIntermediaireRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<PatientIntermediaire?> ajouter(
      PatientIntermediaire patientintermediaire) async {
    //si l'id généré est unique alors on ajouter le patient intermediaire
    if (_checkTempID(patientintermediaire)) {
      await patientintermediaires.add(patientintermediaire);
      return patientintermediaire;
    } else {
      return null;
    }
  }

  @override
  Future<PatientIntermediaire?> trouver(String identifiantTemporaire) async {
    return await patientintermediaires
        .where('identifiantTemporaire', isEqualTo: identifiantTemporaire)
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
  Future<void> modifier(PatientIntermediaire patientintermediaire) {
    return patientintermediaires
        .where('identifiantTemporaire',
            isEqualTo: patientintermediaire.identifiantTemporaire)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            patientintermediaire,
            SetOptions(mergeFields: [
              'nom',
              'prenoms',
              'telephone',
              'email',
              'adresse',
            ]));
      }
    }).catchError((onError) => null);
  }

  @override
  Future<List<PatientIntermediaire>> lister() async {
    return await patientintermediaires.get().then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<PatientIntermediaire> liste = [];
        for (var document in snapshot.docs) {
          PatientIntermediaire patient = document.data();
          liste.add(patient);
        }
        return liste;
      } else {
        List<PatientIntermediaire> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<void> supprimer(PatientIntermediaire patientintermediaire) {
    return patientintermediaires
        .where('identifiantTemporaire',
            isEqualTo: patientintermediaire.identifiantTemporaire)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var document in snapshot.docs) {
          document.reference.delete();
        }
      }
    }).catchError((onError) => null);
  }

  bool _checkTempID(PatientIntermediaire patient) {
    bool checked = true;
    patientintermediaires.get().then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          if (doc['identifiantTemporaire'] == patient.identifiantTemporaire) {
            //on s'assure que le nouveau patient a un ID unique en base données
            checked = false;
          }
        }
      }
    }).catchError((error) => error);
    return checked;
  }
}
