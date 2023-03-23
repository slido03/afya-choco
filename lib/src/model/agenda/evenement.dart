import '../models.dart';

class Evenement {
  final int _id;
  String _titre;
  String _description;
  DateTime _dateHeure;
  final RendezVous _rendezVous;

  Evenement(
    this._id,
    this._titre,
    this._description,
    this._dateHeure,
    this._rendezVous,
  );

  int get id => _id;
  String get titre => _titre;
  String get description => _description;
  DateTime get dateHeure => _dateHeure;
  RendezVous get rendezVous => _rendezVous;

  void setTitre(String titre) => _titre = titre;
  void setDescription(String description) => _description = description;
  void setDateHeure(DateTime dateHeure) => _dateHeure = dateHeure;
}
