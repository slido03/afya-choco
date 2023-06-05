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
    Medecin medecin,
    Patient patient,
    Specialite type,
    DateTime date,
  ) async {
    return await examenRep.trouver(medecin, patient, type, date);
  }

  Future<void> modifier(Examen examen) async {
    await examenRep.modifier(examen);
    notifyListeners();
  }

  //liste des examens du patient courant du plus récent au plus ancien
  Future<List<Examen>> listerPatient(String uidPatient) async {
    return await examenRep.listerPatient(uidPatient);
  }

  //liste des examens du patient selon la catégorie
  Future<List<Examen>> listerPatientSpecialite(
    Specialite type,
    String uidPatient,
  ) async {
    return await examenRep.listerPatientSpecialite(type, uidPatient);
  }

  //liste des examens du patient selon le mois
  Future<List<Examen>> listerPatientMois(
    int mois,
    String uidPatient,
  ) async {
    return await examenRep.listerPatientMois(mois, uidPatient);
  }

  //liste des examens du patient selon la catégorie et le mois
  Future<List<Examen>> listerPatientSpecialiteMois(
    Specialite type,
    int mois,
    String uidPatient,
  ) async {
    return await examenRep.listerPatientSpecialiteMois(type, mois, uidPatient);
  }

  //liste des examens du medecin courant du plus récent au plus ancien
  Future<List<Examen>> listerMedecin(String uidMedecin) async {
    return await examenRep.listerMedecin(uidMedecin);
  }

  //liste des examens du medecin courant selon la catégorie
  Future<List<Examen>> listerMedecinSpecialite(
    Specialite type,
    String uidMedecin,
  ) async {
    return await examenRep.listerMedecinSpecialite(type, uidMedecin);
  }

  //liste des examens du medecin courant selon le mois
  Future<List<Examen>> listerMedecinMois(
    int mois,
    String uidMedecin,
  ) async {
    return await examenRep.listerMedecinMois(mois, uidMedecin);
  }

  //liste des examens du medecin courant selon la catégorie
  Future<List<Examen>> listerMedecinSpecialiteMois(
    Specialite type,
    int mois,
    String uidMedecin,
  ) async {
    return await examenRep.listerMedecinSpecialiteMois(type, mois, uidMedecin);
  }

  Future<void> supprimer(Examen examen) async {
    await examenRep.supprimer(examen);
    notifyListeners();
  }
}
