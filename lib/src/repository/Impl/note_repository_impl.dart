import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteRepositoryImpl extends NoteRepository {
  static NoteRepository? _instance;
  final notes =
      FirebaseFirestore.instance.collection('notes').withConverter<Note>(
            fromFirestore: (snapshot, _) => Note.fromJson(snapshot.data()!),
            toFirestore: (note, _) => note.toJson(),
          ); //collection notes

  NoteRepositoryImpl._(); //constructeur privé

  static NoteRepository get instance {
    _instance ??= NoteRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<Note> ajouter(Note note) async {
    //ajoute la note à la collection
    await notes.add(note);
    return note;
  }

  @override
  Future<void> modifier(Note note) {
    return notes
        .where('evenement.rendez-vous.dateHeure',
            isEqualTo: note.evenement.rendezVous.dateHeure.toIso8601String())
        .where('evenement.rendez-vous.medecin.identifiant',
            isEqualTo: note.evenement.rendezVous.medecin.identifiant)
        .where('evenement.rendez-vous.patient.identifiant',
            isEqualTo: note.evenement.rendezVous.patient.identifiant)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            note,
            SetOptions(mergeFields: [
              'titre',
              'description',
            ]));
      }
    }).catchError((onError) => null);
  }

  @override
  Future<List<Note>> lister(Evenement evenement) async {
    return await notes
        .where('evenement.rendez-vous.dateHeure',
            isEqualTo: evenement.rendezVous.dateHeure.toIso8601String())
        .where('evenement.rendez-vous.medecin.identifiant',
            isEqualTo: evenement.rendezVous.medecin.identifiant)
        .where('evenement.rendez-vous.patient.identifiant',
            isEqualTo: evenement.rendezVous.patient.identifiant)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Note> liste = [];
        for (var document in snapshot.docs) {
          Note note = document.data();
          liste.add(note);
        }
        return liste;
      } else {
        List<Note> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<void> supprimer(Evenement evenement) {
    return notes
        .where('evenement.rendez-vous.dateHeure',
            isEqualTo: evenement.rendezVous.dateHeure.toIso8601String())
        .where('evenement.rendez-vous.medecin.identifiant',
            isEqualTo: evenement.rendezVous.medecin.identifiant)
        .where('evenement.rendez-vous.patient.identifiant',
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
