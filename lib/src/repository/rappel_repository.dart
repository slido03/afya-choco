import '../model/models.dart';

abstract class RappelRepository {
  //repository api
  Future<Rappel> ajouter(Rappel rappel);
  Future<Rappel?> trouver(DateTime dateHeure, Evenement evenement);
  Future<void> modifier(Rappel rappel);
  Future<List<Rappel>> lister(Evenement evenement);
  Future<void> supprimer(Rappel rappel);
}
