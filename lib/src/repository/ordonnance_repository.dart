import '../model/models.dart';

abstract class OrdonnanceRepository {
  //repository api
  Future<Ordonnance> ajouter(Ordonnance ordonnance);
  Future<Ordonnance?> trouver(Diagnostic diagnostic);
  Future<void> modifier(Ordonnance ordonnance);
  Future<List<Ordonnance>> listerPatient(Patient patient);
  Future<List<Ordonnance>> listerMedecin(Medecin medecin);
  Future<void> supprimer(Ordonnance ordonnance);
}
