import '../model/models.dart';

abstract class NoteRepository {
  //repository api
  Future<Note> ajouter(Note note);
  Future<void> modifier(Note note);
  Future<List<Note>> lister(Evenement evenement);
  Future<void> supprimer(Evenement evenement);
}
