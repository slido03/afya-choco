import '../model/models.dart';

abstract class StatutMedicalRepository {
  //repository api
  Future<StatutMedical> ajouter(StatutMedical statutmedical);
  Future<StatutMedical?> trouver(String identifiantPatient);
  Future<void> modifier(StatutMedical statutmedical);
  Future<List<StatutMedical>> lister();
  Future<void> supprimer(String identifiantPatient);
}
