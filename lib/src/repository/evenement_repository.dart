import '../model/models.dart';

abstract class EvenementRepository {
  //repository api
  Future<Evenement> ajouter(Evenement evenement);
  Future<Evenement?> trouver(RendezVous rendezVous);
  Future<void> modifier(Evenement evenement);
  Future<List<Evenement>> listerPatient(String uidPatient);
  Future<List<Evenement>> listerMedecin(String uidMedecin);
  Future<void> supprimer(RendezVous rendezVous);
}
