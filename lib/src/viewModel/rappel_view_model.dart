import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class RappelViewModel extends ChangeNotifier {
  RappelRepository rappelRep = RappelRepositoryImpl.instance;

  //ajout d'un rappel dans la base de données
  Future<void> ajouter(Rappel rappel) async {
    await rappelRep.ajouter(rappel);
    notifyListeners();
  }

  Future<Rappel?> trouver(DateTime dateHeure, Evenement evenement) async {
    return await rappelRep.trouver(dateHeure, evenement);
  }

  Future<void> modifier(Rappel rappel) async {
    await rappelRep.modifier(rappel);
    notifyListeners();
  }

  Future<List<Rappel>> lister() async {
    return await rappelRep.lister();
  }

  //liste des rappels de l'évènement spécifié du plus récent au plus ancien
  Future<List<Rappel>> listerEvenement(Evenement evenement) async {
    return await rappelRep.listerEvenement(evenement);
  }

  Future<void> supprimer(Rappel rappel) async {
    await rappelRep.supprimer(rappel);
    notifyListeners();
  }
}
