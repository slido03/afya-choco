import '../model/models.dart';

abstract class OrdonnanceRepository {
  //repository api
  Future<Ordonnance> ajouter(Ordonnance ordonnance);
  Future<Ordonnance?> trouver(Diagnostic diagnostic);
  Future<void> modifier(Ordonnance ordonnance);
  Future<List<Ordonnance>> listerPatient(String uidPatient);
  Future<List<Ordonnance>> listerMedecin(String uidMedecin);
  Future<void> supprimer(Ordonnance ordonnance);
}
