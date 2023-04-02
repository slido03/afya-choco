import '../model/models.dart';

abstract class PatientRepository {
  //repository api
  Future<Patient?> ajouter(Patient patient);
  Future<Patient?> trouver(String identifiant);
  //trouve le patient ayant l'uid spécifié (utile pour vérifier si l'utilisateur courant est un patient)
  Future<Patient?> trouverUid(String uid);
  Future<void> modifier(Patient patient);
  Future<List<Patient>> lister();
  Future<void> supprimer(String identifiant);
}
