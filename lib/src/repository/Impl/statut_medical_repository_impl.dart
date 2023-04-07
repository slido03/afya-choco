import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatutMedicalRepositoryImpl extends StatutMedicalRepository {
  static StatutMedicalRepository? _instance;
  final statutmedicaux = FirebaseFirestore.instance
      .collection('statutmedicaux')
      .withConverter<StatutMedical>(
        fromFirestore: (snapshot, _) =>
            StatutMedical.fromJson(snapshot.data()!),
        toFirestore: (statutmedical, _) => statutmedical.toJson(),
      ); //collection statutmedicaux

  StatutMedicalRepositoryImpl._(); //constructeur privé

  static StatutMedicalRepository get instance {
    _instance ??= StatutMedicalRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<StatutMedical> ajouter(StatutMedical statutmedical) async {
    //ajoute le rappel à la collection
    await statutmedicaux.add(statutmedical);
    return statutmedical;
  }

  @override
  Future<StatutMedical?> trouver(String identifiantPatient) async {
    return await statutmedicaux
        .where('patient.identifiant', isEqualTo: identifiantPatient)
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
  Future<void> modifier(StatutMedical statutmedical) {
    return statutmedicaux
        .where('patient.identifiant',
            isEqualTo: statutmedical.patient.identifiant)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            statutmedical,
            SetOptions(mergeFields: [
              'groupeSanguin',
              'allergies',
              'maladiesHereditaires',
            ]));
      }
    }).catchError((onError) => null);
  }

  @override
  Future<List<StatutMedical>> lister() async {
    return await statutmedicaux.get().then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<StatutMedical> liste = [];
        for (var document in snapshot.docs) {
          StatutMedical statutMedical = document.data();
          liste.add(statutMedical);
        }
        return liste;
      } else {
        List<StatutMedical> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<void> supprimer(String identifiantPatient) {
    return statutmedicaux
        .where('patient.identifiant', isEqualTo: identifiantPatient)
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
