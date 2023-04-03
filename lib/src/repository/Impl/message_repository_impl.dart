import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageRepositoryImpl extends MessageRepository {
  static MessageRepository? _instance;
  final messages =
      FirebaseFirestore.instance.collection('messages').withConverter<Message>(
            fromFirestore: (snapshot, _) => Message.fromJson(snapshot.data()!),
            toFirestore: (message, _) => message.toJson(),
          ); //collection messages

  final secretaires = FirebaseFirestore.instance
      .collection('secretaires')
      .withConverter<Secretaire>(
        fromFirestore: (snapshot, _) => Secretaire.fromJson(snapshot.data()!),
        toFirestore: (secretaire, _) => secretaire.toJson(),
      ); //collection secretaires

  MessageRepositoryImpl._(); //constructeur privé

  static MessageRepository get instance {
    _instance ??= MessageRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<Message> envoyer(Message message) async {
    //ajoute le message à la collection
    await messages.add(message);
    return message;
  }

  @override
  Future<Message?> trouver(
    String uidExpediteur,
    String uidDestinataire,
    DateTime dateHeure,
  ) async {
    return await messages
        .where('expediteur.uid', isEqualTo: uidExpediteur)
        .where('destinataire.uid', isEqualTo: uidDestinataire)
        .where('dateHeure', isEqualTo: dateHeure.millisecondsSinceEpoch)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.single.exists) {
        return snapshot.docs.single.data();
      } else {
        return null;
      }
    }).catchError((onError) => null);
  }

  //modifie uniquement le statut d'un message
  @override
  Future<void> modifierStatut(Message message) {
    return messages
        .where('expediteur.uid', isEqualTo: message.expediteur.uid)
        .where('destinataire.uid', isEqualTo: message.destinataire.uid)
        .where('dateHeure', isEqualTo: message.dateHeure.millisecondsSinceEpoch)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            message,
            SetOptions(mergeFields: [
              'statut',
            ]));
      }
    }).catchError((onError) => null);
  }

  //lister les messages envoyés en fonction de l'objet
  @override
  Future<List<Message>> listerEnvoye(
      String uidExpediteur, ObjetMessage objet) async {
    return await messages
        .where('expediteur.uid', isEqualTo: uidExpediteur)
        .where('objet', isEqualTo: objet.name)
        .orderBy('dateHeure', descending: true)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Message> liste = [];
        for (var document in snapshot.docs) {
          Message message = document.data();
          liste.add(message);
        }
        return liste;
      } else {
        List<Message> emptyList = [];
        return emptyList;
      }
    });
  }

  //lister les messages reçus en fonction de l'objet
  @override
  Future<List<Message>> listerRecu(
      String uidDestinataire, ObjetMessage objet) async {
    return await messages
        .where('destinataire.uid', isEqualTo: uidDestinataire)
        .where('objet', isEqualTo: objet.name)
        .orderBy('dateHeure', descending: true)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Message> liste = [];
        for (var document in snapshot.docs) {
          Message message = document.data();
          liste.add(message);
        }
        return liste;
      } else {
        List<Message> emptyList = [];
        return emptyList;
      }
    });
  }

  //lister les messages reçus traités ou non traités
  @override
  Future<List<Message>> listerStatut(
      String uidDestinataire, StatutMessage statut) async {
    return await messages
        .where('destinataire.uid', isEqualTo: uidDestinataire)
        .where('statut', isEqualTo: statut.name)
        .orderBy('dateHeure', descending: true)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Message> liste = [];
        for (var document in snapshot.docs) {
          Message message = document.data();
          liste.add(message);
        }
        return liste;
      } else {
        List<Message> emptyList = [];
        return emptyList;
      }
    });
  }

  @override
  Future<void> supprimer(Message message) {
    return messages
        .where('expediteur.uid', isEqualTo: message.expediteur.uid)
        .where('destinataire.uid', isEqualTo: message.destinataire.uid)
        .where('dateHeure', isEqualTo: message.dateHeure.millisecondsSinceEpoch)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var document in snapshot.docs) {
          document.reference.delete();
        }
      }
    }).catchError((onError) => null);
  }
}
