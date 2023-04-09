import '../models.dart';
import 'package:faker/faker.dart';

class Evenement {
  String _titre;
  String _description;
  final RendezVous _rendezVous;

  Evenement(
    this._titre,
    this._description,
    this._rendezVous,
  );

  factory Evenement.fromJson(Map<String, dynamic> json) {
    return Evenement(
      json['titre'] as String,
      json['description'] as String,
      RendezVous.fromJson(json['rendezVous']),
    );
  }

  factory Evenement.faker(RendezVous rendezVous) {
    var faker = Faker();
    var titre = faker.lorem.sentence();
    var description = faker.lorem.sentence();
    return Evenement(
      titre,
      description,
      rendezVous,
    );
  }

  String get titre => _titre;
  String get description => _description;
  RendezVous get rendezVous => _rendezVous;

  void setTitre(String titre) => _titre = titre;
  void setDescription(String description) => _description = description;

  Map<String, dynamic> toJson() => {
        'titre': titre,
        'description': description,
        'rendezVous': rendezVous.toJson(),
      };
}
