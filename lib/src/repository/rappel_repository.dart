import '../model/models.dart';

abstract class RappelRepository {
  //repository api
  Future<Rappel> ajouter(Rappel rappel);
  Future<Rappel?> trouver(DateTime dateHeure, Evenement evenement);
  Future<void> modifier(Rappel rappel);
  Future<List<Rappel>> lister();
  //listes des rappels en attente du patient
  Future<List<Rappel>> listerEnAttentePatient3Jours(String uidPatient);
  Future<List<Rappel>> listerEnAttentePatientSemaine(String uidPatient);
  Future<List<Rappel>> listerEnAttentePatientMois(String uidPatient);
  //listes des rappels en attente du médecin
  Future<List<Rappel>> listerEnAttenteMedecin3Jours(String uidMedecin);
  Future<List<Rappel>> listerEnAttenteMedecinSemaine(String uidMedecin);
  Future<List<Rappel>> listerEnAttenteMedecinMois(String uidMedecin);
  //rappels passés
  Future<List<Rappel>> listerPassePatient(String uidPatient);
  Future<List<Rappel>> listerPasseMedecin(String uidMedecin);
  Future<List<Rappel>> listerEvenement(Evenement evenement);
  Future<void> supprimer(Rappel rappel);
}
