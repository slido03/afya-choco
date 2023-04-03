import '../model/models.dart';

abstract class SecretaireRepository {
  //repository api
  Future<Secretaire?> ajouter(Secretaire secretaire);
  Future<Secretaire?> trouver(String identifiant);
  //trouve le secretaire ayant l'uid spécifié (utile pour vérifier si l'utilisateur courant est un secretaire)
  Future<Secretaire?> trouverUid(String uid);
  //récupère l'utilisateur représentant le secrétariat central
  Future<Secretaire?> getSecretariatCentral();
  Future<void> modifier(Secretaire secretaire);
  Future<List<Secretaire>> lister();
  Future<void> supprimer(String identifiant);
}
