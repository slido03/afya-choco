import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class RappelViewModel extends ChangeNotifier {
  RappelRepository rappelRep = RappelRepositoryImpl.instance;

  //ajout d'un rappel dans la base de données
  void ajouter(Rappel rappel) {
    rappelRep.ajouter(rappel);
    notifyListeners();
  }

  Future<Rappel?> trouver(DateTime dateHeure, Evenement evenement) async {
    return await rappelRep.trouver(dateHeure, evenement);
  }

  void modifier(Rappel rappel) {
    rappelRep.modifier(rappel);
    notifyListeners();
  }

  //liste des rappels de l'évènement spécifié du plus récent au plus ancien
  Future<List<Rappel>> lister(Evenement evenement) async {
    return await rappelRep.lister(evenement);
  }

  void supprimer(Rappel rappel) {
    rappelRep.supprimer(rappel);
    notifyListeners();
  }
}
