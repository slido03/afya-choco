import '../model/models.dart';

abstract class EvenementRepository {
  //dao api

  Future<Evenement> ajouter(Evenement evenement);
  Future<Evenement?> trouver(RendezVous rendezVous);
  Future<void> modifier(Evenement evenement);
  Future<List<Evenement>> listerEvenementPatient(Patient patient);
  Future<List<Evenement>> listerEvenementMedecin(Medecin medecin);
  Future<void> supprimer(Evenement evenement);
}
