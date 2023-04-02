import '../model/models.dart';

abstract class MedecinRepository {
  //repository api
  Future<Medecin?> ajouter(Medecin medecin);
  Future<Medecin?> trouver(String identifiant);
  //trouve le medecin ayant l'uid spécifié (utile pour vérifier si l'utilisateur courant est un medecin)
  Future<Medecin?> trouverUid(String uid);
  Future<void> modifier(Medecin medecin);
  Future<List<Medecin>> lister();
  Future<void> supprimer(String identifiant);
}
