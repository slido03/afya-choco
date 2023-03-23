import '../models.dart';

class Diagnostic {
  final int _id;
  DateTime _date;
  String _description;
  final Medecin _medecin;
  final List<Examen> _examens = [];
  StatutDiagnostic _statut;

  Diagnostic(
    this._id,
    this._date,
    this._description,
    this._medecin,
    this._statut,
  );

  int get id => _id;
  DateTime get date => _date;
  String get description => _description;
  Medecin get medecin => _medecin;
  List<Examen> get examens => _examens;
  StatutDiagnostic get statut => _statut;
  int get nombreExamens => _examens.length;

  void setDate(DateTime date) => _date = date;
  void setDescription(String description) => _description = description;
  void setStatut(StatutDiagnostic statut) => _statut = statut;

  void ajouterExamen(Examen examen) => _examens.add(examen);
  void supprimerExamen(Examen examen) => _examens.remove(examen);
}
