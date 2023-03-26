import '../model/models.dart';

abstract class DiagnosticRepository {
  //dao api

  Future<Diagnostic> ajouter(Diagnostic diagnostic);
  Future<Diagnostic?> trouver(DateTime date, Medecin medecin, Patient patient);
  Future<void> modifier(Diagnostic diagnostic);
  Future<List<Diagnostic>> lister(Patient patient);
  Future<void> supprimer(Diagnostic diagnostic);
}
