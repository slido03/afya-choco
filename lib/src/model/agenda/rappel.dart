import '../models.dart';
import 'package:faker/faker.dart';

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
      DateTime.fromMillisecondsSinceEpoch(json['dateHeure']),
      Evenement.fromJson(json['evenement']),
    );
  }

  factory Rappel.faker(Evenement evenement) {
    var faker = Faker();
    var titre = faker.lorem.sentence();
    var description = faker.lorem.sentence();
    var dateHeure = faker.date.dateTime(minYear: 2022, maxYear: 2023);
    return Rappel(
      titre,
      description,
      dateHeure,
      evenement,
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
        'dateHeure': dateHeure.millisecondsSinceEpoch,
        'evenement': evenement.toJson(),
      };
}
