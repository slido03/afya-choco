import '../model/models.dart';

abstract class CarnetRepository {
  //repository api
  Future<Carnet> ajouter(Carnet carnet);
  Future<Carnet?> trouver(String identifiantPatient);
  Future<List<Carnet>> lister();
  Future<void> supprimer(String identifiantPatient);
}
