import '../model/models.dart';

abstract class EvenementRepository {
  //repository api
  Future<Evenement> ajouter(Evenement evenement);
  Future<Evenement?> trouver(RendezVous rendezVous);
  Future<void> modifier(Evenement evenement);
  //évnements en attente
  Future<List<Evenement>> listerEnAttentePatient(String uidPatient);
  Future<List<Evenement>> listerEnAttenteMedecin(String uidMedecin);
  //évènements passés
  Future<List<Evenement>> listerPassePatient(String uidPatient);
  Future<List<Evenement>> listerPasseMedecin(String uidMedecin);
  Future<void> supprimer(RendezVous rendezVous);
}
