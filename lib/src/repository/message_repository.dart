import '../model/models.dart';

abstract class MessageRepository {
  //repository api
  Future<Message> envoyer(Message message);
  Future<Message?> trouver(
    String uidExpediteur,
    String uidDestinataire,
    DateTime dateHeure,
  );
  //modifie uniquement le statut d'un message
  Future<void> modifierStatut(Message message);
  //lister les messages envoyés en fonction de l'objet
  Future<List<Message>> listerEnvoye(String uidExpediteur, ObjetMessage objet);
  //lister les messages reçus en fonction de l'objet
  Future<List<Message>> listerRecuObjet(String uidDestinataire, ObjetMessage objet);
  //lister tous les messages reçus 
  Future<List<Message>> listerRecu(String uidDestinataire);
  //lister les messages reçus traités ou non traités
  Future<List<Message>> listerRecuStatut(
      String uidDestinataire, StatutMessage statut);

  Future<void> supprimer(Message message);
}
