import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class NoteViewModel extends ChangeNotifier {
  NoteRepository noteRep = NoteRepositoryImpl.instance;

  //ajout d'un note dans la base de données
  void ajouter(Note note) {
    noteRep.ajouter(note);
    notifyListeners();
  }

  void modifier(Note note) {
    noteRep.modifier(note);
    notifyListeners();
  }

  //liste des notes de l'évènement spécifié du plus récent au plus ancien
  Future<List<Note>> lister(Evenement evenement) async {
    return await noteRep.lister(evenement);
  }

  void supprimer(Evenement evenement) {
    noteRep.supprimer(evenement);
    notifyListeners();
  }
}
