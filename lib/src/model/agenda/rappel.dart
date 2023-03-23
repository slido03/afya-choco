import '../models.dart';

class Rappel {
  final int _id;
  String _titre;
  String? _description;
  DateTime _dateHeure;
  final Evenement _evenement;

  Rappel(
    this._id,
    this._titre,
    this._description,
    this._dateHeure,
    this._evenement,
  );

  int get id => _id;
  String get titre => _titre;
  String? get description => _description;
  DateTime get dateHeure => _dateHeure;
  Evenement get evenement => _evenement;

  void setTitre(String titre) => _titre = titre;
  void setDescription(String? description) => _description = description;
  void setDateHeure(DateTime dateHeure) => _dateHeure = dateHeure;
}
