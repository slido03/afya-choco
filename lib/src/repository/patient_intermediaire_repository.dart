import '../model/models.dart';

abstract class PatientIntermediaireRepository {
  //repository api
  Future<PatientIntermediaire?> ajouter(
      PatientIntermediaire patientintermediaire);
  Future<PatientIntermediaire?> trouver(String identifiantTemporaire);
  //trouve le patientIntermediaire ayant l'uid spécifié (utile pour vérifier si l'utilisateur courant est un PatientInermediaire)
  Future<PatientIntermediaire?> trouverUid(String uid);
  Future<void> modifier(PatientIntermediaire patientintermediaire);
  Future<List<PatientIntermediaire>> lister();
  Future<void> supprimer(String identifiantTemporaire);
}
