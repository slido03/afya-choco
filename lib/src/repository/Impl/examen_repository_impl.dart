import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExamenRepositoryImpl extends ExamenRepository {
  static ExamenRepository? _instance;
  final examens =
      FirebaseFirestore.instance.collection('examens').withConverter<Examen>(
            fromFirestore: (snapshot, _) => Examen.fromJson(snapshot.data()!),
            toFirestore: (examen, _) => examen.toJson(),
          ); //collection examens

  ExamenRepositoryImpl._(); //constructeur privé

  static ExamenRepository get instance {
    _instance ??= ExamenRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<Examen> ajouter(Examen examen) async {
    //ajoute l'examen à la collection
    await examens.add(examen);
    return examen;
  }

  @override
  Future<Examen?> trouver(
      Medecin medecin, Patient patient, Specialite type, DateTime date) async {
    return await examens
        .where('medecin.identifiant', isEqualTo: medecin.identifiant)
        .where('patient.identifiant', isEqualTo: patient.identifiant)
        .where('type', isEqualTo: type.name)
        .where('date', isEqualTo: date.toIso8601String())
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
  Future<void> modifier(Examen examen) {
    return examens
        .where('medecin.identifiant', isEqualTo: examen.medecin.identifiant)
        .where('patient.identifiant', isEqualTo: examen.patient.identifiant)
        .where('type', isEqualTo: examen.type.name)
        .where('date', isEqualTo: examen.date.toIso8601String())
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            examen,
            SetOptions(mergeFields: [
              'resultats',
            ]));
      }
    }).catchError((onError) => null);
  }

  @override
  Future<List<Examen>> lister(Patient patient) async {
    return await examens
        .where('patient.identifiant', isEqualTo: patient.identifiant)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Examen> liste = [];
        for (var document in snapshot.docs) {
          Examen examen = document.data();
          liste.add(examen);
        }
        return liste;
      } else {
        List<Examen> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<void> supprimer(Examen examen) {
    return examens
        .where('medecin.identifiant', isEqualTo: examen.medecin.identifiant)
        .where('patient.identifiant', isEqualTo: examen.patient.identifiant)
        .where('type', isEqualTo: examen.type.name)
        .where('date', isEqualTo: examen.date.toIso8601String())
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
