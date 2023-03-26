import '../models.dart';

class Note {
  String _titre;
  String _description;
  final Evenement _evenement;

  Note(
    this._titre,
    this._description,
    this._evenement,
  );

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      json['titre'] as String,
      json['description'] as String,
      Evenement.fromJson(json['evenement']),
    );
  }

  String get titre => _titre;
  String get description => _description;
  Evenement get evenement => _evenement;
  void setTitre(String titre) => _titre = titre;
  void setDescription(String description) => _description = description;

  Map<String, dynamic> toJson() => {
        'titre': titre,
        'description': description,
        'evenement': evenement.toJson(),
      };
}
