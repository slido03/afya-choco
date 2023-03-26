import '../model/models.dart';

abstract class SecretaireRepository {
  //dao api
  Future<Secretaire?> ajouter(Secretaire secretaire);
  Future<Secretaire?> trouver(String identifiant);
  Future<void> modifier(Secretaire secretaire);
  Future<List<Secretaire>> lister();
  Future<void> supprimer(String identifiant);
}
