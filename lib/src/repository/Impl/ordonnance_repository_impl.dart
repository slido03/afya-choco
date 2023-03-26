import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdonnanceRepositoryImpl extends OrdonnanceRepository {
  static OrdonnanceRepository? _instance;
  final ordonnances = FirebaseFirestore.instance
      .collection('ordonnances')
      .withConverter<Ordonnance>(
        fromFirestore: (snapshot, _) => Ordonnance.fromJson(snapshot.data()!),
        toFirestore: (ordonnance, _) => ordonnance.toJson(),
      ); //collection ordonnances

  OrdonnanceRepositoryImpl._(); //constructeur privé

  static OrdonnanceRepository get instance {
    _instance ??= OrdonnanceRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<Ordonnance> ajouter(Ordonnance ordonnance) async {
    //ajoute l'ordonnance à la collection
    await ordonnances.add(ordonnance);
    return ordonnance;
  }

  @override
  Future<Ordonnance?> trouver(Diagnostic diagnostic) async {
    return await ordonnances
        .where('diagnostic.date', isEqualTo: diagnostic.date.toIso8601String())
        .where('medecin.identifiant', isEqualTo: diagnostic.medecin.identifiant)
        .where('patient.identifiant',
            isEqualTo: diagnostic.patient!.identifiant)
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
  Future<void> modifier(Ordonnance ordonnance) {
    return ordonnances
        .where('diagnostic.date',
            isEqualTo: ordonnance.diagnostic.date.toIso8601String())
        .where('diagnostic.medecin.identifiant',
            isEqualTo: ordonnance.diagnostic.medecin.identifiant)
        .where('diagnostic.patient.identifiant',
            isEqualTo: ordonnance.diagnostic.patient!.identifiant)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            ordonnance,
            SetOptions(mergeFields: [
              'instructions',
            ]));
      }
    }).catchError((onError) => null);
  }

  @override
  Future<List<Ordonnance>> lister(Patient patient) async {
    return await ordonnances
        .where('diagnostic.patient.identifiant', isEqualTo: patient.identifiant)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Ordonnance> liste = [];
        for (var document in snapshot.docs) {
          Ordonnance ordonnance = document.data();
          liste.add(ordonnance);
        }
        return liste;
      } else {
        List<Ordonnance> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<void> supprimer(Ordonnance ordonnance) {
    return ordonnances
        .where('diagnostic.date',
            isEqualTo: ordonnance.diagnostic.date.toIso8601String())
        .where('diagnostic.medecin.identifiant',
            isEqualTo: ordonnance.diagnostic.medecin.identifiant)
        .where('diagnostic.patient.identifiant',
            isEqualTo: ordonnance.diagnostic.patient!.identifiant)
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
