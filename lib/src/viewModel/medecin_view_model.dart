import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class MedecinViewModel extends ChangeNotifier {
  MedecinRepository medecinRep = MedecinRepositoryImpl.instance;

  Future<void> ajouter(Medecin medecin) async {
    Medecin? p;
    //on attribut un identifiant unique au medecin
    medecin.setIdentifiant();
    //on essaie de l'ajouter à la base de données
    p = await medecinRep.ajouter(medecin);
    //Tant que l'ajout échoue à cause de la non-unicité de l'identifiant
    while (p == null) {
      //on affecte un autre ientifiant au medecin
      medecin.setIdentifiant();
      //puis on essaie l'ajout à nouveau
      p = await medecinRep.ajouter(medecin);
    }
    //à la sortie de la boucle le medecin a effectivement été ajouté
    notifyListeners();
  }

  //permet la recherche d'un medecin depuis l'UI à partir de son identifiant système
  Future<Medecin?> trouver(String identifiant) async {
    return await medecinRep.trouver(identifiant);
  }

  //permet de s'assurer si l'utilisateur courant est de ce type
  Future<Medecin?> trouverUid(String uid) async {
    return await medecinRep.trouverUid(uid);
  }

  Future<void> modifier(Medecin medecin) async {
    await medecinRep.modifier(medecin);
    notifyListeners();
  }

  Future<void> supprimer(String identifiant) async {
    await medecinRep.supprimer(identifiant);
    notifyListeners();
  }

  Future<List<Medecin>> lister() async {
    return await medecinRep.lister();
  }
}
