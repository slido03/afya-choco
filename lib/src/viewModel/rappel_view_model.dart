import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class RappelViewModel extends ChangeNotifier {
  RappelRepository rappelRep = RappelRepositoryImpl.instance;

  //ajout d'un rappel dans la base de données
  Future<void> ajouter(Rappel rappel) async {
    await rappelRep.ajouter(rappel);
    notifyListeners();
  }

  Future<Rappel?> trouver(DateTime dateHeure, Evenement evenement) async {
    return await rappelRep.trouver(dateHeure, evenement);
  }

  Future<void> modifier(Rappel rappel) async {
    await rappelRep.modifier(rappel);
    notifyListeners();
  }

  Future<List<Rappel>> lister() async {
    return await rappelRep.lister();
  }

  Future<List<Rappel>> listerEnAttentePatient3Jours(String uidPatient) async {
    return await rappelRep.listerEnAttentePatient3Jours(uidPatient);
  }

  Future<List<Rappel>> listerEnAttentePatientSemaine(String uidPatient) async {
    return await rappelRep.listerEnAttentePatientSemaine(uidPatient);
  }

  Future<List<Rappel>> listerEnAttentePatientMois(String uidPatient) async {
    return await rappelRep.listerEnAttentePatientMois(uidPatient);
  }

  Future<List<Rappel>> listerEnAttenteMedecin3Jours(String uidMedecin) async {
    return await rappelRep.listerEnAttenteMedecin3Jours(uidMedecin);
  }

  Future<List<Rappel>> listerEnAttenteMedecinSemaine(String uidMedecin) async {
    return await rappelRep.listerEnAttenteMedecinSemaine(uidMedecin);
  }

  Future<List<Rappel>> listerEnAttenteMedecinMois(String uidMedecin) async {
    return await rappelRep.listerEnAttenteMedecinMois(uidMedecin);
  }

  Future<List<Rappel>> listerPassePatient(String uidPatient) async {
    return await rappelRep.listerPassePatient(uidPatient);
  }

  Future<List<Rappel>> listerPasseMedecin(String uidMedecin) async {
    return await rappelRep.listerPasseMedecin(uidMedecin);
  }

  //liste des rappels de l'évènement spécifié du plus récent au plus ancien
  Future<List<Rappel>> listerEvenement(Evenement evenement) async {
    return await rappelRep.listerEvenement(evenement);
  }

  Future<void> supprimer(Rappel rappel) async {
    await rappelRep.supprimer(rappel);
    notifyListeners();
  }
}
