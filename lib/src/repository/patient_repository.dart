import '../model/models.dart';

abstract class PatientRepository {
  //dao api

  Future<Patient?> ajouter(Patient patient);
  Future<Patient?> trouver(String identifiant);
  Future<void> modifier(Patient patient);
  Future<List<Patient>> lister();
  Future<void> supprimer(String identifiant);
}
