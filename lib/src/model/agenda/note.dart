import '../models.dart';
import 'package:faker/faker.dart';

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
      json['titre'],
      json['description'],
      Evenement.fromJson(json['evenement']),
    );
  }

  factory Note.faker(Evenement evenement) {
    var faker = Faker();
    var titre = faker.lorem.sentence();
    var description = faker.lorem.sentence();
    return Note(
      titre,
      description,
      evenement,
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
