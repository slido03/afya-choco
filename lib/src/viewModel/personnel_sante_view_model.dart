import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class PersonnelSanteViewModel extends ChangeNotifier {
  PersonnelSanteRepository personnelsanteRep =
      PersonnelSanteRepositoryImpl.instance;

  Future<void> ajouter(PersonnelSante personnelsante) async {
    PersonnelSante? p;
    //on attribut un identifiant unique au personnelsante
    personnelsante.setIdentifiant();
    //on essaie de l'ajouter à la base de données
    p = await personnelsanteRep.ajouter(personnelsante);
    //Tant que l'ajout échoue à cause de la non-unicité de l'identifiant
    while (p == null) {
      //on affecte un autre ientifiant au personnelsante
      personnelsante.setIdentifiant();
      //puis on essaie l'ajout à nouveau
      p = await personnelsanteRep.ajouter(personnelsante);
    }
    //à la sortie de la boucle le personnelsante a effectivement été ajouté
    notifyListeners();
  }

  //permet la recherche d'un personnelSante depuis l'UI à partir de son identifiant système
  Future<PersonnelSante?> trouver(String identifiant) async {
    return await personnelsanteRep.trouver(identifiant);
  }

  //permet de s'assurer si l'utilisateur courant est de ce type
  Future<PersonnelSante?> trouverUid(String uid) async {
    return await personnelsanteRep.trouverUid(uid);
  }

  Future<void> modifier(PersonnelSante personnelsante) async {
    await personnelsanteRep.modifier(personnelsante);
    notifyListeners();
  }

  Future<void> supprimer(String identifiant) async {
    await personnelsanteRep.supprimer(identifiant);
    notifyListeners();
  }

  Future<List<PersonnelSante>> lister() async {
    return await personnelsanteRep.lister();
  }
}
