import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class PatientIntermedaireViewModel extends ChangeNotifier {
  PatientIntermediaireRepository patientIntermediaireRep =
      PatientIntermediaireRepositoryImpl.instance;

  void ajouter(PatientIntermediaire patientIntermediaire) async {
    PatientIntermediaire? p;
    //on attribut un identifiant unique au patientintermedaire
    patientIntermediaire.setIdentifiant();
    //on essaie de l'ajouter à la base de données
    p = await patientIntermediaireRep.ajouter(patientIntermediaire);
    //Tant que l'ajout échoue à cause de la non-unicité de l'identifiant
    while (p == null) {
      //on affecte un autre ientifiant au patientintermedaire
      patientIntermediaire.setIdentifiant();
      //puis on essaie l'ajout à nouveau
      p = await patientIntermediaireRep.ajouter(patientIntermediaire);
    }
    //à la sortie de la boucle le patientintermedaire a effectivement été ajouté
    notifyListeners();
  }

  //permet la recherche d'un patientIntermediaire depuis l'UI à partir de son identifiant système
  Future<PatientIntermediaire?> trouver(String identifiant) async {
    return patientIntermediaireRep.trouver(identifiant);
  }

  //permet de s'assurer si l'utilisateur courant est de ce type
  Future<PatientIntermediaire?> trouverUid(String uid) async {
    return patientIntermediaireRep.trouverUid(uid);
  }

  void modifier(PatientIntermediaire patientIntermediaire) {
    patientIntermediaireRep.modifier(patientIntermediaire);
    notifyListeners();
  }

  void supprimer(String identifiant) {
    patientIntermediaireRep.supprimer(identifiant);
    notifyListeners();
  }

  Future<List<PatientIntermediaire>> lister() async {
    return await patientIntermediaireRep.lister();
  }
}
