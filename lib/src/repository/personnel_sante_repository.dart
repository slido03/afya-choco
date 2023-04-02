import '../model/models.dart';

abstract class PersonnelSanteRepository {
  //repository api
  Future<PersonnelSante?> ajouter(PersonnelSante personnelsante);
  Future<PersonnelSante?> trouver(String identifiant);
  //trouve le personnelSante ayant l'uid spécifié (utile pour vérifier si l'utilisateur courant est un personnelSante)
  Future<PersonnelSante?> trouverUid(String uid);
  Future<void> modifier(PersonnelSante personnelsante);
  Future<List<PersonnelSante>> lister();
  Future<void> supprimer(String identifiant);
}
