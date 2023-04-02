import '../model/models.dart';

abstract class DiagnosticRepository {
  //repository api
  Future<Diagnostic> ajouter(Diagnostic diagnostic);
  Future<Diagnostic?> trouver(DateTime date, Medecin medecin, Patient patient);
  Future<void> modifier(Diagnostic diagnostic);
  Future<List<Diagnostic>> listerPatient(Patient patient);
  Future<List<Diagnostic>> listerMedecin(Medecin medecin);
  Future<void> supprimer(Diagnostic diagnostic);
}
