import '../model/models.dart';

abstract class RappelRepository {
  //repository api
  Future<Rappel> ajouter(Rappel rappel);
  Future<Rappel?> trouver(DateTime dateHeure, Evenement evenement);
  Future<void> modifier(Rappel rappel);
  Future<List<Rappel>> lister();
  Future<List<Rappel>> listerEnAttentePatient(String uidPatient);
  Future<List<Rappel>> listerEnAttenteMedecin(String uidMedecin);
  Future<List<Rappel>> listerPassePatient(String uidPatient);
  Future<List<Rappel>> listerPasseMedecin(String uidMedecin);
  Future<List<Rappel>> listerEvenement(Evenement evenement);
  Future<void> supprimer(Rappel rappel);
}
