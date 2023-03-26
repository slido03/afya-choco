import '../models.dart';

class Diagnostic {
  final DateTime _date;
  String _description;
  final Medecin _medecin;
  List<Examen> _examens = [];
  StatutDiagnostic _statut;

  Diagnostic(
    this._date,
    this._description,
    this._medecin,
    this._examens,
    this._statut,
  );

  factory Diagnostic.fromJson(Map<String, dynamic> json) {
    return Diagnostic(
      DateTime.parse(json['date']),
      json['description'] as String,
      Medecin.fromJson(json['medecin']),
      examensFromJson(json['examens']),
      parseStatut(json['statut']),
    );
  }

  DateTime get date => _date;
  String get description => _description;
  Medecin get medecin => _medecin;
  List<Examen> get examens => _examens;
  StatutDiagnostic get statut => _statut;
  int get nombreExamens => _examens.length;
  Patient? get patient {
    if (examens.isNotEmpty) {
      return examens.first.patient;
    }
    return null;
  }

  List<Map<String, dynamic>> get examensJson =>
      examens.map((e) => e.toJson()).toList();

  void setDescription(String description) => _description = description;
  void setStatut(StatutDiagnostic statut) => _statut = statut;

  void ajouterExamen(Examen examen) => _examens.add(examen);
  void supprimerExamen(Examen examen) => _examens.remove(examen);

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'description': description,
        'patient': patient!.toJson(),
        'medecin': medecin.toJson(),
        'examens': examensJson,
        'statut': statut.name,
      };

  static StatutDiagnostic parseStatut(String name) {
    StatutDiagnostic statut = StatutDiagnostic.values
        .firstWhere((s) => s.toString() == 'StatutDiagnostic.$name');
    return statut;
  }

  static List<Examen> examensFromJson(List<Map<String, dynamic>> examensJson) {
    List<Examen> examens =
        examensJson.map((examen) => Examen.fromJson(examen)).toList();
    return examens;
  }
}
