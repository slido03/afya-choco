import '../model/models.dart';

abstract class PatientIntermediaireRepository {
  //dao api

  Future<PatientIntermediaire?> ajouter(
      PatientIntermediaire patientintermediaire);
  Future<PatientIntermediaire?> trouver(String identifiantTemporaire);
  Future<void> modifier(PatientIntermediaire patientintermediaire);
  Future<List<PatientIntermediaire>> lister();
  Future<void> supprimer(PatientIntermediaire patientintermediaire);
}
