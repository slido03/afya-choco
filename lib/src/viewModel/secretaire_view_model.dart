import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class SecretaireViewModel extends ChangeNotifier {
  SecretaireRepository secretaireRep = SecretaireRepositoryImpl.instance;

  void ajouter(Secretaire secretaire) async {
    Secretaire? p;
    //on attribut un identifiant unique au secretaire
    secretaire.setIdentifiant();
    //on essaie de l'ajouter à la base de données
    p = await secretaireRep.ajouter(secretaire);
    //Tant que l'ajout échoue à cause de la non-unicité de l'identifiant
    while (p == null) {
      //on affecte un autre ientifiant au secretaire
      secretaire.setIdentifiant();
      //puis on essaie l'ajout à nouveau
      p = await secretaireRep.ajouter(secretaire);
    }
    //à la sortie de la boucle le secretaire a effectivement été ajouté
    notifyListeners();
  }

  //permet la recherche d'un secretaire depuis l'UI à partir de son identifiant système
  Future<Secretaire?> trouver(String identifiant) async {
    return secretaireRep.trouver(identifiant);
  }

  //permet de s'assurer si l'utilisateur courant est de ce type
  Future<Secretaire?> trouverUid(String uid) async {
    return secretaireRep.trouverUid(uid);
  }

  void modifier(Secretaire secretaire) {
    secretaireRep.modifier(secretaire);
    notifyListeners();
  }

  void supprimer(String identifiant) {
    secretaireRep.supprimer(identifiant);
    notifyListeners();
  }

  Future<List<Secretaire>> lister() async {
    return await secretaireRep.lister();
  }
}
