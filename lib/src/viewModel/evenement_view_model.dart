import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class EvenementViewModel extends ChangeNotifier {
  EvenementRepository evenementRep = EvenementRepositoryImpl.instance;

  //ajout d'un evenement dans la base de données
  Future<void> ajouter(Evenement evenement) async {
    await evenementRep.ajouter(evenement);
    notifyListeners();
  }

  Future<Evenement?> trouver(RendezVous rendezVous) async {
    return await evenementRep.trouver(rendezVous);
  }

  Future<void> modifier(Evenement evenement) async {
    await evenementRep.modifier(evenement);
    notifyListeners();
  }

  //liste des evenements du patient courant du plus récent au plus ancien
  Future<List<Evenement>> listerPatient(String uidPatient) async {
    return await evenementRep.listerPatient(uidPatient);
  }

  //liste des evenements du medecin courant du plus récent au plus ancien
  Future<List<Evenement>> listerMedecin(String uidMedecin) async {
    return await evenementRep.listerMedecin(uidMedecin);
  }

  Future<void> supprimer(RendezVous rendezVous) async {
    await evenementRep.supprimer(rendezVous);
    notifyListeners();
  }
}
