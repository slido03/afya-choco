import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class NoteViewModel extends ChangeNotifier {
  NoteRepository noteRep = NoteRepositoryImpl.instance;

  //ajout d'un note dans la base de données
  Future<void> ajouter(Note note) async {
    await noteRep.ajouter(note);
    notifyListeners();
  }

  Future<void> modifier(Note note) async {
    await noteRep.modifier(note);
    notifyListeners();
  }

  //liste des notes de l'évènement spécifié du plus récent au plus ancien
  Future<List<Note>> lister(Evenement evenement) async {
    return await noteRep.lister(evenement);
  }

  Future<void> supprimer(Evenement evenement) async {
    await noteRep.supprimer(evenement);
    notifyListeners();
  }
}
