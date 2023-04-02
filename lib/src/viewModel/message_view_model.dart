import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class MessageViewModel extends ChangeNotifier {
  MessageRepository messageRep = MessageRepositoryImpl.instance;

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
}
