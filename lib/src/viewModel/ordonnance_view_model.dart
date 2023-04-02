import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class OrdonnanceViewModel extends ChangeNotifier {
  OrdonnanceRepository ordonnanceRep = OrdonnanceRepositoryImpl.instance;

  //ajout d'un ordonnance dans la base de données
  void ajouter(Ordonnance ordonnance) {
    ordonnanceRep.ajouter(ordonnance);
    notifyListeners();
  }

  Future<Ordonnance?> trouver(Diagnostic diagnostic) async {
    return await ordonnanceRep.trouver(diagnostic);
  }

  void modifier(Ordonnance ordonnance) {
    ordonnanceRep.modifier(ordonnance);
    notifyListeners();
  }

  //liste des ordonnance du patient courant du plus récent au plus ancien
  Future<List<Ordonnance>> listerPatient(Patient patient) async {
    return await ordonnanceRep.listerPatient(patient);
  }

  //liste des ordonnance du medecin courant du plus récent au plus ancien
  Future<List<Ordonnance>> listerMedecin(Medecin medecin) async {
    return await ordonnanceRep.listerMedecin(medecin);
  }

  void supprimer(Ordonnance ordonnance) {
    ordonnanceRep.supprimer(ordonnance);
    notifyListeners();
  }
}
