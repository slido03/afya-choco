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

  Future<List<Evenement>> lister() async {
    return await evenementRep.lister();
  }

  //liste des evenements du patient courant du plus récent au plus ancien
  Future<List<Evenement>> listerEnAttentePatient3Jours(
      String uidPatient) async {
    return await evenementRep.listerEnAttentePatient3Jours(uidPatient);
  }

  Future<List<Evenement>> listerEnAttentePatientSemaine(
      String uidPatient) async {
    return await evenementRep.listerEnAttentePatientSemaine(uidPatient);
  }

  Future<List<Evenement>> listerEnAttentePatientMois(String uidPatient) async {
    return await evenementRep.listerEnAttentePatientMois(uidPatient);
  }

  //liste des evenements du medecin courant du plus récent au plus ancien
  Future<List<Evenement>> listerEnAttenteMedecin3Jours(
      String uidMedecin) async {
    return await evenementRep.listerEnAttenteMedecin3Jours(uidMedecin);
  }

  Future<List<Evenement>> listerEnAttenteMedecinSemaine(
      String uidMedecin) async {
    return await evenementRep.listerEnAttenteMedecinSemaine(uidMedecin);
  }

  Future<List<Evenement>> listerEnAttenteMedecinMois(String uidMedecin) async {
    return await evenementRep.listerEnAttenteMedecinMois(uidMedecin);
  }

  //historique des évènements du patient
  Future<List<Evenement>> listerPassePatient(String uidPatient) async {
    return await evenementRep.listerPassePatient(uidPatient);
  }

  //historique des évènements du patient
  Future<List<Evenement>> listerPasseMedecin(String uidMedecin) async {
    return await evenementRep.listerPasseMedecin(uidMedecin);
  }

  Future<void> supprimer(RendezVous rendezVous) async {
    await evenementRep.supprimer(rendezVous);
    notifyListeners();
  }
}
