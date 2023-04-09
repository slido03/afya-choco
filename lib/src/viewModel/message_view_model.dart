import 'package:flutter/foundation.dart';
import '../repository/repositories.dart';

class MessageViewModel extends ChangeNotifier {
  MessageRepository messageRep = MessageRepositoryImpl.instance;
  PatientIntermediaireRepository patientIntermediaireRep =
      PatientIntermediaireRepositoryImpl.instance;
  SecretaireRepository secretaireRep = SecretaireRepositoryImpl.instance;
  PatientRepository patientRep = PatientRepositoryImpl.instance;

  //ajout d'un message dans la base de données
  Future<void> envoyer(Message message) async {
    await messageRep.envoyer(message);
    notifyListeners();
  }

  Future<Message?> trouver(
    String uidExpediteur,
    String uidDestinataire,
    DateTime dateHeure,
  ) async {
    Message? message =
        await messageRep.trouver(uidExpediteur, uidDestinataire, dateHeure);
    return message;
  }

  //change le statut d'un message de non traité à traité
  void modifierStatut(Message message) {
    //on vérifie le statut initial avant de faire la modification
    if (message.statut == StatutMessage.nonTraite) {
      message.changerStatut(StatutMessage.traite);
      messageRep.modifierStatut(message);
      notifyListeners();
    }
  }

  //liste des messages envoyés par l'utilisateur courant du plus récent au plus ancien
  Future<List<Message>> listerEnvoye(
      String uidExpediteur, ObjetMessage objet) async {
    return await messageRep.listerEnvoye(uidExpediteur, objet);
  }

  //liste des messages reçus par l'utilisateur courant en fonction de l'objet du plus récent au plus ancien
  Future<List<Message>> listerRecuObjet(
      String uidDestinataire, ObjetMessage objet) async {
    return await messageRep.listerRecuObjet(uidDestinataire, objet);
  }

  //liste de tous les messages reçus par l'utilisateur
  Future<List<Message>> listerRecu(String uidDestinataire) async {
    return await messageRep.listerRecu(uidDestinataire);
  }

  //lister les messages reçus traités ou non traités par l'utilisateur courant
  Future<List<Message>> listerRecuStatut(
      String uidDestinataire, StatutMessage statut) async {
    return await messageRep.listerRecuStatut(uidDestinataire, statut);
  }

  Future<Secretaire?> getSecretariatCentral() async {
    //faire en sorte que l'objet secretaire central existe en permanence
    if (kDebugMode) {
      print('recherche du secretariat central');
    }
    return await secretaireRep.getSecretariatCentral();
  }

  Future<void> supprimer(Message message) async {
    await messageRep.supprimer(message);
    notifyListeners();
  }

  Future<PatientIntermediaire> ajouter(
      PatientIntermediaire patientIntermediaire) async {
    PatientIntermediaire? p;
    //on attribut un identifiant temporaire unique au patientintermedaire
    patientIntermediaire.setIdentifiantTemporaire();
    //on essaie de l'ajouter à la base de données
    p = await patientIntermediaireRep.ajouter(patientIntermediaire);
    //Tant que l'ajout échoue à cause de la non-unicité de l'identifiant temporaire
    while (p == null) {
      //on affecte un autre ientifiant temporaire au patientintermedaire
      patientIntermediaire.setIdentifiantTemporaire();
      //puis on essaie l'ajout à nouveau
      p = await patientIntermediaireRep.ajouter(patientIntermediaire);
    }
    //à la sortie de la boucle le patientintermedaire a effectivement été ajouté
    notifyListeners();
    if (kDebugMode) {
      print("ajout effectué");
    }
    return p;
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
}
