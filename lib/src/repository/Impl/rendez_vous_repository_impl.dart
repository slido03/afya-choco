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
        .where('dateHeure', isEqualTo: dateHeure.toIso8601String())
        .where('medecin.identifiant', isEqualTo: medecin.identifiant)
        .where('patient.identifiant', isEqualTo: patient.identifiant)
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
  Future<void> modifier(RendezVous rendezVous) {
    return rendezvous
        .where('dateHeure', isEqualTo: rendezVous.dateHeure.toIso8601String())
        .where('medecin.identifiant', isEqualTo: rendezVous.medecin.identifiant)
        .where('patient.identifiant', isEqualTo: rendezVous.patient.identifiant)
        .limit(1)
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
  Future<List<RendezVous>> lister() async {
    return await rendezvous.get().then((snapshot) {
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
  Future<void> supprimer(RendezVous rendezVous) {
    return rendezvous
        .where('dateHeure', isEqualTo: rendezVous.dateHeure.toIso8601String())
        .where('medecin.identifiant', isEqualTo: rendezVous.medecin.identifiant)
        .where('patient.identifiant', isEqualTo: rendezVous.patient.identifiant)
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
