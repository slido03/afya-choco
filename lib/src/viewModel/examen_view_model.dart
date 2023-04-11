import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class ExamenViewModel extends ChangeNotifier {
  ExamenRepository examenRep = ExamenRepositoryImpl.instance;

  //ajout d'un examen dans la base de données
  Future<void> ajouter(Examen examen) async {
    await examenRep.ajouter(examen);
    notifyListeners();
  }

  Future<Examen?> trouver(
      Medecin medecin, Patient patient, Specialite type, DateTime date) async {
    return await examenRep.trouver(medecin, patient, type, date);
  }

  Future<void> modifier(Examen examen) async {
    await examenRep.modifier(examen);
    notifyListeners();
  }

  //liste des examen du patient courant du plus récent au plus ancien
  Future<List<Examen>> listerPatient(String uidPatient) async {
    return await examenRep.listerPatient(uidPatient);
  }

  //liste des examen du medecin courant du plus récent au plus ancien
  Future<List<Examen>> listerMedecin(String uidMedecin) async {
    return await examenRep.listerMedecin(uidMedecin);
  }

  Future<void> supprimer(Examen examen) async {
    await examenRep.supprimer(examen);
    notifyListeners();
  }
}
