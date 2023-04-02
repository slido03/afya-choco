import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class RendezVousViewModel extends ChangeNotifier {
  RendezVousRepository rendezvousRep = RendezVousRepositoryImpl.instance;

  //ajout d'un rendezvous dans la base de données
  void ajouter(RendezVous rendezvous) {
    rendezvousRep.ajouter(rendezvous);
    notifyListeners();
  }

  Future<RendezVous?> trouver(
      DateTime dateHeure, Patient patient, Medecin medecin) async {
    return await rendezvousRep.trouver(dateHeure, patient, medecin);
  }

  void modifier(RendezVous rendezvous) {
    rendezvousRep.modifier(rendezvous);
    notifyListeners();
  }

  //liste des rendezvous du patient courant du plus récent au plus ancien
  Future<List<RendezVous>> listerPatient(String uidPatient) async {
    return await rendezvousRep.listerPatient(uidPatient);
  }

  //liste des rendezvous du medecin courant du plus récent au plus ancien
  Future<List<RendezVous>> listerMedecin(String uidMedecin) async {
    return await rendezvousRep.listerMedecin(uidMedecin);
  }

  void supprimer(RendezVous rendezvous) {
    rendezvousRep.supprimer(rendezvous);
    notifyListeners();
  }
}
