import '../model/models.dart';

abstract class OrdonnanceRepository {
  //dao api

  Future<Ordonnance> ajouter(Ordonnance ordonnance);
  Future<Ordonnance?> trouver(Diagnostic diagnostic);
  Future<void> modifier(Ordonnance ordonnance);
  Future<List<Ordonnance>> lister(Patient patient);
  Future<void> supprimer(Ordonnance ordonnance);
}
