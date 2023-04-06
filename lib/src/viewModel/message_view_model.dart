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
    List<Message> liste = await messageRep.listerEnvoye(uidExpediteur, objet);
    return liste;
  }

  //liste des messages reçus par l'utilisateur courant du plus récent au plus ancien
  Future<List<Message>> listerRecu(
      String uidDestinataire, ObjetMessage objet) async {
    List<Message> liste = await messageRep.listerRecu(uidDestinataire, objet);
    return liste;
  }

  //lister les messages reçus traités ou non traités par l'utilisateur courant
  Future<List<Message>> listerStatut(
      String uidDestinataire, StatutMessage statut) async {
    List<Message> liste =
        await messageRep.listerStatut(uidDestinataire, statut);
    return liste;
  }

  Future<Secretaire?> getSecretariatCentral() async {
    //faire en sorte que l'objet secretaire central existe en permanence
    if (kDebugMode) {
      print('recherche du secretariat central');
    }
    Secretaire? secretaire = await secretaireRep.getSecretariatCentral();
    if (kDebugMode) {
      print('fin de recherche du secretariat central');
      //print(secretaire.toString());
    }
    if (secretaire == null) {
      if (kDebugMode) {
        print(
            "erreur lors de la recherche du secretariat central : l'objet est nul");
      }
    }
    return secretaire;
  }

  void supprimer(Message message) {
    messageRep.supprimer(message);
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
    PatientIntermediaire? patient =
        await patientIntermediaireRep.trouverUid(uid);
    return patient;
  }

//permet de s'assurer si l'utilisateur courant est un patient
  Future<Patient?> trouverPatientUid(String uid) async {
    Patient? patient = await patientRep.trouverUid(uid);
    return patient;
  }
}
