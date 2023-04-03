import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class MessageViewModel extends ChangeNotifier {
  MessageRepository messageRep = MessageRepositoryImpl.instance;
  PatientIntermediaireRepository patientIntermediaireRep =
      PatientIntermediaireRepositoryImpl.instance;

  //ajout d'un message dans la base de données
  void envoyer(Message message) {
    messageRep.envoyer(message);
    notifyListeners();
  }

  Future<Message?> trouver(
    String uidExpediteur,
    String uidDestinataire,
    DateTime dateHeure,
  ) async {
    return await messageRep.trouver(uidExpediteur, uidDestinataire, dateHeure);
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

  //liste des messages reçus par l'utilisateur courant du plus récent au plus ancien
  Future<List<Message>> listerRecu(
      String uidDestinataire, ObjetMessage objet) async {
    return await messageRep.listerRecu(uidDestinataire, objet);
  }

  //lister les messages reçus traités ou non traités par l'utilisateur courant
  Future<List<Message>> listerStatut(
      String uidDestinataire, StatutMessage statut) async {
    return await messageRep.listerStatut(uidDestinataire, statut);
  }

  void supprimer(Message message) {
    messageRep.supprimer(message);
    notifyListeners();
  }

  void ajouter(PatientIntermediaire patientIntermediaire) async {
    PatientIntermediaire? p;
    //on attribut un identifiant unique au patientintermedaire
    patientIntermediaire.setIdentifiant();
    //on essaie de l'ajouter à la base de données
    p = await patientIntermediaireRep.ajouter(patientIntermediaire);
    //Tant que l'ajout échoue à cause de la non-unicité de l'identifiant
    while (p == null) {
      //on affecte un autre ientifiant au patientintermedaire
      patientIntermediaire.setIdentifiant();
      //puis on essaie l'ajout à nouveau
      p = await patientIntermediaireRep.ajouter(patientIntermediaire);
    }
    //à la sortie de la boucle le patientintermedaire a effectivement été ajouté
    notifyListeners();
  }

  //permet la recherche d'un patientIntermediaire depuis l'UI à partir de son identifiant système
  Future<PatientIntermediaire?> trouverPatient(String identifiant) async {
    return patientIntermediaireRep.trouver(identifiant);
  }

  //permet de s'assurer si l'utilisateur courant est de ce type
  Future<PatientIntermediaire?> trouverUid(String uid) async {
    return patientIntermediaireRep.trouverUid(uid);
  }
}
