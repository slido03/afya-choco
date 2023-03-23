import '../models.dart';

class Carnet {
  final int _id;
  final Patient _proprietaire;
  final List<Examen> _examens;
  final List<Ordonnance> _ordonnances;

  Carnet(
    this._id,
    this._proprietaire,
    this._examens,
    this._ordonnances,
  );

  int get id => _id;
  Patient get proprietaire => _proprietaire;
  List<Examen> get examens => _examens;
  List<Ordonnance> get ordonnances => _ordonnances;
  int get nombreExamens => _examens.length;
  int get nombreOrdonnances => _ordonnances.length;

  void ajouterExamen(Examen examen) => _examens.add(examen);
  void ajouterOrdonnance(Ordonnance ordonnance) => _ordonnances.add(ordonnance);
  void supprimerExamen(Examen examen) => _examens.remove(examen);
  void supprimerOrdonnance(Ordonnance ordonnance) =>
      _ordonnances.remove(ordonnance);
}
