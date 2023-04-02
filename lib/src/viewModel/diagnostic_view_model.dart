import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class DiagnosticViewModel extends ChangeNotifier {
  DiagnosticRepository diagnosticRep = DiagnosticRepositoryImpl.instance;

  //ajout d'un diagnostic dans la base de données
  void ajouter(Diagnostic diagnostic) {
    diagnosticRep.ajouter(diagnostic);
    notifyListeners();
  }

  Future<Diagnostic?> trouver(
      DateTime date, Medecin medecin, Patient patient) async {
    return await diagnosticRep.trouver(date, medecin, patient);
  }

  void modifier(Diagnostic diagnostic) {
    diagnosticRep.modifier(diagnostic);
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

  void supprimer(Diagnostic diagnostic) {
    diagnosticRep.supprimer(diagnostic);
    notifyListeners();
  }
}
