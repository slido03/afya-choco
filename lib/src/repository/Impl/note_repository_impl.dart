import 'package:flutter/foundation.dart';

import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteRepositoryImpl extends NoteRepository {
  static NoteRepository? _instance;
  static final _firestore = FirebaseFirestore.instance;
  final notes = _firestore.collection('notes').withConverter<Note>(
        fromFirestore: (snapshot, _) => Note.fromJson(snapshot.data()!),
        toFirestore: (note, _) => note.toJson(),
      ); //collection notes

  NoteRepositoryImpl._() {
    //on initialise le cache local de firestore
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: 20 * 1024 * 1024,
    );
  } //constructeur privé

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
        .where('evenement.rendezVous.medecin.uid',
            isEqualTo: note.evenement.rendezVous.medecin.uid)
        .where('evenement.rendezVous.patient.uid',
            isEqualTo: note.evenement.rendezVous.patient.uid)
        .where('evenement.rendezVous.dateHeure',
            isEqualTo:
                note.evenement.rendezVous.dateHeure.millisecondsSinceEpoch)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            note,
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
  Future<List<Note>> lister(Evenement evenement) async {
    return await notes
        .where('evenement.rendezVous.medecin.uid',
            isEqualTo: evenement.rendezVous.medecin.uid)
        .where('evenement.rendezVous.patient.uid',
            isEqualTo: evenement.rendezVous.patient.uid)
        .where('evenement.rendezVous.dateHeure',
            isEqualTo: evenement.rendezVous.dateHeure.millisecondsSinceEpoch)
        .get(const GetOptions(source: Source.serverAndCache))
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
  Future<void> supprimer(Note note) {
    return notes
        .where('titre', isEqualTo: note.titre)
        .where('evenement.rendezVous.medecin.uid',
            isEqualTo: note.evenement.rendezVous.medecin.uid)
        .where('evenement.rendezVous.patient.uid',
            isEqualTo: note.evenement.rendezVous.patient.uid)
        .where('evenement.rendezVous.dateHeure',
            isEqualTo:
                note.evenement.rendezVous.dateHeure.millisecondsSinceEpoch)
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

  @override
  Future<void> supprimerEvenement(Evenement evenement) {
    return notes
        .where('evenement.rendezVous.medecin.uid',
            isEqualTo: evenement.rendezVous.medecin.uid)
        .where('evenement.rendezVous.patient.uid',
            isEqualTo: evenement.rendezVous.patient.uid)
        .where('evenement.rendezVous.dateHeure',
            isEqualTo: evenement.rendezVous.dateHeure.millisecondsSinceEpoch)
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
