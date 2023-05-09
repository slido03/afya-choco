import '../model/models.dart';

abstract class EvenementRepository {
  //repository api
  Future<Evenement> ajouter(Evenement evenement);
  Future<Evenement?> trouver(RendezVous rendezVous);
  Future<void> modifier(Evenement evenement);
  Future<List<Evenement>> lister();
  //évènements en attente du patient
  Future<List<Evenement>> listerEnAttentePatient3Jours(String uidPatient);
  Future<List<Evenement>> listerEnAttentePatientSemaine(String uidPatient);
  Future<List<Evenement>> listerEnAttentePatientMois(String uidPatient);
  //évènements en attente du médecin
  Future<List<Evenement>> listerEnAttenteMedecin3Jours(String uidMedecin);
  Future<List<Evenement>> listerEnAttenteMedecinSemaine(String uidMedecin);
  Future<List<Evenement>> listerEnAttenteMedecinMois(String uidMedecin);
  //évènements passés
  Future<List<Evenement>> listerPassePatient(String uidPatient);
  Future<List<Evenement>> listerPasseMedecin(String uidMedecin);
  Future<void> supprimer(RendezVous rendezVous);
}
