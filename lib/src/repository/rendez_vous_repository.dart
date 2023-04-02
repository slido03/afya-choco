import '../model/models.dart';

abstract class RendezVousRepository {
  //repository api
  Future<RendezVous> ajouter(RendezVous rendezVous);
  Future<RendezVous?> trouver(
      DateTime dateHeure, Patient patient, Medecin medecin);
  Future<void> modifier(RendezVous rendezVous);
  Future<List<RendezVous>> listerPatient(String uidPatient);
  Future<List<RendezVous>> listerMedecin(String uidMedecin);
  Future<void> supprimer(RendezVous rendezVous);
}
