import 'package:flutter/material.dart';
import '../repository/repositories.dart';

class StatutMedicalViewModel extends ChangeNotifier {
  StatutMedicalRepository statutmedicalRep =
      StatutMedicalRepositoryImpl.instance;

  //ajout d'un statutmedical dans la base de données
  Future<void> ajouter(StatutMedical statutmedical) async {
    await statutmedicalRep.ajouter(statutmedical);
    notifyListeners();
  }

  Future<StatutMedical?> trouver(String identifiantPatient) async {
    return await statutmedicalRep.trouver(identifiantPatient);
  }

  Future<StatutMedical?> trouverUid(String uidPatient) async {
    return await statutmedicalRep.trouverUid(uidPatient);
  }

  Future<void> modifier(StatutMedical statutmedical) async {
    await statutmedicalRep.modifier(statutmedical);
    notifyListeners();
  }

  //liste des statutmedicals de l'évènement spécifié du plus récent au plus ancien
  Future<List<StatutMedical>> lister() async {
    return await statutmedicalRep.lister();
  }

  Future<void> supprimer(String identifiantPatient) async {
    await statutmedicalRep.supprimer(identifiantPatient);
    notifyListeners();
  }
}
