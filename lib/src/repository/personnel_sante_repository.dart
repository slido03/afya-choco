import '../model/models.dart';

abstract class PersonnelSanteRepository {
  //dao api

  Future<PersonnelSante?> ajouter(PersonnelSante personnelsante);
  Future<PersonnelSante?> trouver(String identifiant);
  Future<void> modifier(PersonnelSante personnelsante);
  Future<List<PersonnelSante>> lister();
  Future<void> supprimer(String identifiant);
}
