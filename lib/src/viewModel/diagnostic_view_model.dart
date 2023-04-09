import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class DiagnosticViewModel extends ChangeNotifier {
  DiagnosticRepository diagnosticRep = DiagnosticRepositoryImpl.instance;

  //ajout d'un diagnostic dans la base de données
  Future<void> ajouter(Diagnostic diagnostic) async {
    await diagnosticRep.ajouter(diagnostic);
    notifyListeners();
  }

  Future<Diagnostic?> trouver(
      DateTime date, Medecin medecin, Patient patient) async {
    return await diagnosticRep.trouver(date, medecin, patient);
  }

  Future<void> modifier(Diagnostic diagnostic) async {
    await diagnosticRep.modifier(diagnostic);
    notifyListeners();
  }

  //liste des diagnostic du patient courant du plus récent au plus ancien
  Future<List<Diagnostic>> listerPatient(Patient patient) async {
    return await diagnosticRep.listerPatient(patient);
  }

  //liste des diagnostic du medecin courant du plus récent au plus ancien
  Future<List<Diagnostic>> listerMedecin(Medecin medecin) async {
    return await diagnosticRep.listerMedecin(medecin);
  }

  Future<void> supprimer(Diagnostic diagnostic) async {
    await diagnosticRep.supprimer(diagnostic);
    notifyListeners();
  }
}
