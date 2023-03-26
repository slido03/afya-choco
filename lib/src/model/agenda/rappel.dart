import '../models.dart';

class Rappel {
  String _titre;
  String? _description;
  final DateTime _dateHeure;
  final Evenement _evenement;

  Rappel(
    this._titre,
    this._description,
    this._dateHeure,
    this._evenement,
  );

  factory Rappel.fromJson(Map<String, dynamic> json) {
    return Rappel(
      json['titre'] as String,
      json['description'] as String,
      DateTime.parse(json['dateHeure']),
      Evenement.fromJson(json['evenement']),
    );
  }

  String get titre => _titre;
  String? get description => _description;
  DateTime get dateHeure => _dateHeure;
  Evenement get evenement => _evenement;

  void setTitre(String titre) => _titre = titre;
  void setDescription(String? description) => _description = description;

  Map<String, dynamic> toJson() => {
        'titre': titre,
        'description': description,
        'dateHeure': dateHeure.toIso8601String(),
        'évènement': evenement.toJson(),
      };
}
