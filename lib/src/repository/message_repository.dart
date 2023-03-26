import '../model/models.dart';

abstract class MessageRepository {
  //dao api

  Future<Message> envoyer(Message message);
  Future<Message?> trouver(
    Utilisateur expediteur,
    Utilisateur destinataire,
    DateTime dateHeure,
  );
  //modifie uniquement le statut d'un message
  Future<void> modifierStatut(Message message);
  //lister les messages envoyés en fonction de l'objet
  Future<List<Message>> lister(Utilisateur expediteur, ObjetMessage objet);
  //lister les messages reçus en fonction de l'objet
  Future<List<Message>> listerObjet(Utilisateur destinaire, ObjetMessage objet);
  //lister les messages reçus traités ou non traités
  Future<List<Message>> listerStatut(
      Utilisateur destinaire, StatutMessage statut);

  Future<void> supprimer(Message message);
}
