import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class OrdonnanceViewModel extends ChangeNotifier {
  OrdonnanceRepository ordonnanceRep = OrdonnanceRepositoryImpl.instance;

  //ajout d'un ordonnance dans la base de données
  Future<void> ajouter(Ordonnance ordonnance) async {
    await ordonnanceRep.ajouter(ordonnance);
    notifyListeners();
  }

  Future<Ordonnance?> trouver(Diagnostic diagnostic) async {
    return await ordonnanceRep.trouver(diagnostic);
  }

  Future<void> modifier(Ordonnance ordonnance) async {
    await ordonnanceRep.modifier(ordonnance);
    notifyListeners();
  }

  //liste des ordonnance du patient courant du plus récent au plus ancien
  Future<List<Ordonnance>> listerPatient(String uidPatient) async {
    return await ordonnanceRep.listerPatient(uidPatient);
  }

  //liste des ordonnance du medecin courant du plus récent au plus ancien
  Future<List<Ordonnance>> listerMedecin(String uidMedecin) async {
    return await ordonnanceRep.listerMedecin(uidMedecin);
  }

  Future<void> supprimer(Ordonnance ordonnance) async {
    await ordonnanceRep.supprimer(ordonnance);
    notifyListeners();
  }
}
