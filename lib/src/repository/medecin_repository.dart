import '../model/models.dart';

abstract class MedecinRepository {
  //dao api

  Future<Medecin?> ajouter(Medecin medecin);
  Future<Medecin?> trouver(String identifiant);
  Future<void> modifier(Medecin medecin);
  Future<List<Medecin>> lister();
  Future<void> supprimer(String identifiant);
}
