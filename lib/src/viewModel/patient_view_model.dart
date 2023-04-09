import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class PatientViewModel extends ChangeNotifier {
  PatientRepository patientRep = PatientRepositoryImpl.instance;

  Future<void> ajouter(Patient patient) async {
    Patient? p;
    //on attribut un identifiant unique au patient
    patient.setIdentifiant();
    //on essaie de l'ajouter à la base de données
    p = await patientRep.ajouter(patient);
    //Tant que l'ajout échoue à cause de la non-unicité de l'identifiant
    while (p == null) {
      //on affecte un autre identifiant au patient
      patient.setIdentifiant();
      //puis on essaie l'ajout à nouveau
      p = await patientRep.ajouter(patient);
    }
    //à la sortie de la boucle le patient a effectivement été ajouté
    notifyListeners();
  }

  //permet la recherche d'un patient depuis l'UI à partir de son identifiant système
  Future<Patient?> trouver(String identifiant) async {
    return patientRep.trouver(identifiant);
  }

  //permet de s'assurer si l'utilisateur courant est de ce type
  Future<Patient?> trouverUid(String uid) async {
    return patientRep.trouverUid(uid);
  }

  Future<void> modifier(Patient patient) async {
    await patientRep.modifier(patient);
    notifyListeners();
  }

  Future<void> supprimer(String identifiant) async {
    await patientRep.supprimer(identifiant);
    notifyListeners();
  }

  Future<List<Patient>> lister() async {
    return await patientRep.lister();
  }
}
