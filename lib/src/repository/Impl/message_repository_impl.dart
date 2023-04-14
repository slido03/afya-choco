import 'package:flutter/foundation.dart';

import '../repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageRepositoryImpl extends MessageRepository {
  static MessageRepository? _instance;
  static final _firestore = FirebaseFirestore.instance;
  final messages =
      FirebaseFirestore.instance.collection('messages').withConverter<Message>(
            fromFirestore: (snapshot, _) => Message.fromJson(snapshot.data()!),
            toFirestore: (message, _) => message.toJson(),
          ); //collection messages

  MessageRepositoryImpl._() {
    //on initialise le cache local de firestore
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: 40 * 1024 * 1024,
    );
  } //constructeur privé

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
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        if (snapshot.docs.first.exists) {
          return snapshot.docs.first.data();
        }
      } else {
        return null;
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      return null;
    });
  }

  //modifie uniquement le statut d'un message
  @override
  Future<void> modifierStatut(Message message) {
    return messages
        .where('expediteur.uid', isEqualTo: message.expediteur.uid)
        .where('destinataire.uid', isEqualTo: message.destinataire.uid)
        .where('dateHeure', isEqualTo: message.dateHeure.millisecondsSinceEpoch)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.set(
            message,
            SetOptions(mergeFields: [
              'statut',
            ]));
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      return null;
    });
  }

  //lister les messages envoyés en fonction de l'objet
  @override
  Future<List<Message>> listerEnvoye(
      String uidExpediteur, ObjetMessage objet) async {
    return await messages
        .where('expediteur.uid', isEqualTo: uidExpediteur)
        .where('objet', isEqualTo: objet.name)
        .orderBy('dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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
  Future<List<Message>> listerRecuObjet(
      String uidDestinataire, ObjetMessage objet) async {
    return await messages
        .where('destinataire.uid', isEqualTo: uidDestinataire)
        .where('objet', isEqualTo: objet.name)
        .orderBy('dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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

  //lister tous les messages reçus
  @override
  Future<List<Message>> listerRecu(String uidDestinataire) async {
    return await messages
        .where('destinataire.uid', isEqualTo: uidDestinataire)
        .orderBy('dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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
  Future<List<Message>> listerRecuStatut(
      String uidDestinataire, StatutMessage statut) async {
    return await messages
        .where('destinataire.uid', isEqualTo: uidDestinataire)
        .where('statut', isEqualTo: statut.name)
        .orderBy('dateHeure', descending: true)
        .get(const GetOptions(source: Source.serverAndCache))
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
        .get(const GetOptions(source: Source.serverAndCache))
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var document in snapshot.docs) {
          document.reference.delete();
        }
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      return null;
    });
  }
}
