import '../model/models.dart';

abstract class RendezVousRepository {
  //dao api

  Future<RendezVous> ajouter(RendezVous rendezVous);
  Future<RendezVous?> trouver(
      DateTime dateHeure, Patient patient, Medecin medecin);
  Future<void> modifier(RendezVous rendezVous);
  Future<List<RendezVous>> lister();
  Future<void> supprimer(RendezVous rendezVous);
}
