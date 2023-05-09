import '../repository/repositories.dart';
import 'package:flutter/foundation.dart';

class RendezVousViewModel extends ChangeNotifier {
  RendezVousRepository rendezvousRep = RendezVousRepositoryImpl.instance;
  PatientIntermediaireRepository patientIntermediaireRep =
      PatientIntermediaireRepositoryImpl.instance;
  SecretaireRepository secretaireRep = SecretaireRepositoryImpl.instance;
  PatientRepository patientRep = PatientRepositoryImpl.instance;

  //ajout d'un rendezvous dans la base de données
  Future<void> ajouter(RendezVous rendezvous) async {
    await rendezvousRep.ajouter(rendezvous);
    notifyListeners();
  }

  Future<RendezVous?> trouver(
      DateTime dateHeure, Patient patient, Medecin medecin) async {
    return await rendezvousRep.trouver(dateHeure, patient, medecin);
  }

  Future<void> modifier(RendezVous rendezvous) async {
    await rendezvousRep.modifier(rendezvous);
    notifyListeners();
  }

  //liste des rendez-vous du patient courant en attente du plus récent au plus ancien
  Future<List<RendezVous>> listerEnAttentePatient(String uidPatient) async {
    return await rendezvousRep.listerEnAttentePatient(uidPatient);
  }

  //liste des rendez-vous du medecin courant en attente du plus récent au plus ancien
  Future<List<RendezVous>> listerEnAttenteMedecin(String uidMedecin) async {
    return await rendezvousRep.listerEnAttenteMedecin(uidMedecin);
  }

  //le dernier rendez-vous du patient
  Future<RendezVous?> getLastForPatient(String uidPatient) async {
    return await rendezvousRep.getLastForPatient(uidPatient);
  }

  //le dernier rendez-vous du médecin
  Future<RendezVous?> getLastForMedecin(String uidMedecin) async {
    return await rendezvousRep.getLastForPatient(uidMedecin);
  }

  Future<void> supprimer(RendezVous rendezvous) async {
    await rendezvousRep.supprimer(rendezvous);
    notifyListeners();
  }

  //permet de s'assurer si l'utilisateur courant est un patient intermediaire
  Future<PatientIntermediaire?> trouverPatientIntermediaireUid(
      String uid) async {
    return await patientIntermediaireRep.trouverUid(uid);
  }

//permet de s'assurer si l'utilisateur courant est un patient
  Future<Patient?> trouverPatientUid(String uid) async {
    return await patientRep.trouverUid(uid);
  }

  Future<Secretaire?> getSecretariatCentral() async {
    //faire en sorte que l'objet secretaire central existe en permanence
    return await secretaireRep.getSecretariatCentral();
  }
}
