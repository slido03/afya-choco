import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class StatutMedicalViewModel extends ChangeNotifier {
  StatutMedicalRepository statutmedicalRep =
      StatutMedicalRepositoryImpl.instance;

  //ajout d'un statutmedical dans la base de données
  void ajouter(StatutMedical statutmedical) {
    statutmedicalRep.ajouter(statutmedical);
    notifyListeners();
  }

  Future<StatutMedical?> trouver(String identifiantPatient) async {
    return await statutmedicalRep.trouver(identifiantPatient);
  }

  void modifier(StatutMedical statutmedical) {
    statutmedicalRep.modifier(statutmedical);
    notifyListeners();
  }

  //liste des statutmedicals de l'évènement spécifié du plus récent au plus ancien
  Future<List<StatutMedical>> lister() async {
    return await statutmedicalRep.lister();
  }

  void supprimer(String identifiantPatient) {
    statutmedicalRep.supprimer(identifiantPatient);
    notifyListeners();
  }
}
