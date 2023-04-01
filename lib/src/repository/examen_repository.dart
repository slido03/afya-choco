import '../model/models.dart';

abstract class ExamenRepository {
  //dao api

  Future<Examen> ajouter(Examen examen);
  Future<Examen?> trouver(
      Medecin medecin, Patient patient, Specialite type, DateTime date);
  Future<void> modifier(Examen examen);
  Future<List<Examen>> lister(Patient patient);
  Future<List<Examen>> listerSpecialite(Specialite type, Patient patient);
  Future<void> supprimer(Examen examen);
}
