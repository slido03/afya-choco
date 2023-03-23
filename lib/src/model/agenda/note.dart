import '../models.dart';

class Note {
  final int _id;
  String _titre;
  String _description;
  final Evenement _evenement;

  Note(
    this._id,
    this._titre,
    this._description,
    this._evenement,
  );

  int get id => _id;
  String get titre => _titre;
  String get description => _description;
  Evenement get evenement => _evenement;
  void setTitre(String titre) => _titre = titre;
  void setDescription(String description) => _description = description;
}
