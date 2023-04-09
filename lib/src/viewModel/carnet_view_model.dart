import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class CarnetViewModel extends ChangeNotifier {
  CarnetRepository carnetRep = CarnetRepositoryImpl.instance;

  //ajout d'un carnet dans la base de données
  Future<void> ajouter(Carnet carnet) async {
    await carnetRep.ajouter(carnet);
    notifyListeners();
  }

  Future<Carnet?> trouver(String identifiantPatient) async {
    return await carnetRep.trouver(identifiantPatient);
  }

  //liste des carnets de l'évènement spécifié du plus récent au plus ancien
  Future<List<Carnet>> lister() async {
    return await carnetRep.lister();
  }

  Future<void> supprimer(String identifiantPatient) async {
    await carnetRep.supprimer(identifiantPatient);
    notifyListeners();
  }
}
