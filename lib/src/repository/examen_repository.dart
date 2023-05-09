import '../model/models.dart';

abstract class ExamenRepository {
  //repository api
  Future<Examen> ajouter(Examen examen);
  Future<Examen?> trouver(
    Medecin medecin,
    Patient patient,
    Specialite type,
    DateTime date,
  );
  Future<void> modifier(Examen examen);
  //liste des examens passés par le patient (simple)
  Future<List<Examen>> listerPatient(String uidPatient);
  //liste des examens passés par le patient (selon la catégorie)
  Future<List<Examen>> listerPatientSpecialite(
    Specialite type,
    String uidPatient,
  );
  //liste des examens passés par le patient (selon le mois)
  Future<List<Examen>> listerPatientMois(
    int mois,
    String uidPatient,
  );
  //liste des examens passés par le patient (selon la catégorie et le mois)
  Future<List<Examen>> listerPatientSpecialiteMois(
    Specialite type,
    int mois,
    String uidPatient,
  );
  //liste des examens effectués par le médecin (simple)
  Future<List<Examen>> listerMedecin(String uidMedecin);
  //liste des examens effectués par le médecin (selon la catégorie)
  Future<List<Examen>> listerMedecinSpecialite(
    Specialite type,
    String uidMedecin,
  );
  //liste des examens effectués par le médecin (selon le mois)
  Future<List<Examen>> listerMedecinMois(
    int mois,
    String uidMedecin,
  );
  //liste des examens effectués par le médecin (selon la catégorie et le mois)
  Future<List<Examen>> listerMedecinSpecialiteMois(
    Specialite type,
    int mois,
    String uidMedecin,
  );

  Future<void> supprimer(Examen examen);
}
