import '../model/models.dart';

abstract class ExamenRepository {
  //repository api
  Future<Examen> ajouter(Examen examen);
  Future<Examen?> trouver(
      Medecin medecin, Patient patient, Specialite type, DateTime date);
  Future<void> modifier(Examen examen);
  Future<List<Examen>> listerPatient(String uidPatient);
  Future<List<Examen>> listerMedecin(String uidMedecin);
  Future<List<Examen>> listerSpecialite(Specialite type, String uidPatient);
  Future<void> supprimer(Examen examen);
}
