import '../models.dart';

class Carnet {
  final Patient _proprietaire;
  final List<Examen> _examens;
  final List<Ordonnance> _ordonnances;

  Carnet(
    this._proprietaire,
    this._examens,
    this._ordonnances,
  );

  factory Carnet.fromJson(Map<String, dynamic> json) {
    return Carnet(
      Patient.fromJson(json['proprietaire']),
      examensFromJson(json['examens']),
      ordonnancesFromJson(json['ordonnances']),
    );
  }

  Patient get proprietaire => _proprietaire;
  List<Examen> get examens => _examens;
  List<Ordonnance> get ordonnances => _ordonnances;
  int get nombreExamens => _examens.length;
  int get nombreOrdonnances => _ordonnances.length;
  List<Map<String, dynamic>> get examensJson =>
      examens.map((e) => e.toJson()).toList();
  List<Map<String, dynamic>> get ordonnancesJson =>
      ordonnances.map((o) => o.toJson()).toList();

  void ajouterExamen(Examen examen) => _examens.add(examen);
  void ajouterOrdonnance(Ordonnance ordonnance) => _ordonnances.add(ordonnance);
  void supprimerExamen(Examen examen) => _examens.remove(examen);
  void supprimerOrdonnance(Ordonnance ordonnance) =>
      _ordonnances.remove(ordonnance);

  Map<String, dynamic> toJson() => {
        'propietaire': proprietaire.toJson(),
        'examens': examensJson,
        'ordonnances': ordonnancesJson,
      };

  static List<Examen> examensFromJson(List<Map<String, dynamic>> examensJson) {
    List<Examen> examens =
        examensJson.map((examen) => Examen.fromJson(examen)).toList();
    return examens;
  }

  static List<Ordonnance> ordonnancesFromJson(
      List<Map<String, dynamic>> ordonnancesJson) {
    List<Ordonnance> ordonnances = ordonnancesJson
        .map((ordonnance) => Ordonnance.fromJson(ordonnance))
        .toList();
    return ordonnances;
  }
}
